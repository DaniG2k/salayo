class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom, only: %i[show edit update destroy]
  layout 'dashboard'

  # def index
  #   @chatrooms = Chatroom.all
  # end

  def show
    @messages = @chatroom.messages.includes(:user).order(created_at: :desc)
    # Get the other user's name. Useful for page title.
    @other_user = @chatroom.users.where.not(id: current_user.id).first.first_name
  end

  # def new
  # end

  # def edit; end

  def create
    sender = User.find params[:sender]
    receiver = User.find params[:receiver]
    # Check if there isn't already a chatroom between the two users
    chatroom_intersection = ChatroomUser.where(user: sender).pluck(:chatroom_id) & ChatroomUser.where(user: receiver).pluck(:chatroom_id)
    if chatroom_intersection.empty?
      @chatroom = Chatroom.new
      @chatroom.name = "Conversation between #{sender.first_name} and #{receiver.first_name}"
      @chatroom.users << [sender, receiver]
      if @chatroom.save
        redirect_to @chatroom
      else
        render :new
      end
    else
      @chatroom = Chatroom.find(chatroom_intersection.first)
      redirect_to @chatroom
    end
  end

  # def update
  #   respond_to do |format|
  #     if @chatroom.update(chatroom_params)
  #       format.html { redirect_to @chatroom, notice: 'Chatroom was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @chatroom }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @chatroom.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # def destroy
  #   @chatroom.destroy
  #   respond_to do |format|
  #     format.html { redirect_to chatrooms_url, notice: 'Chatroom was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  def messages
    @chatrooms = Chatroom.all
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:warning] = 'Unable to find the specified conversation.'
    redirect_to messages_path
  end

  # def chatroom_params
  #   params.require(:chatroom).permit(:name)
  # end
end
