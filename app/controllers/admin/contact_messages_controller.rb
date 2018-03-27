class Admin::ContactMessagesController < Admin::ApplicationController
  before_action :set_contact_message, only: %i[show destroy]

  def index
    @contact_messages = ContactMessage.all
  end

  def show; end

  def destroy
    if @contact_message.destroy
      redirect_to admin_contact_messages_path, notice: 'Contact message successfully destroyed.'
    else
      flash.now[:notice] = 'Contact message was not destroyed.'
      render :show
    end
  end

  private

  def set_contact_message
    @contact_message = ContactMessage.find params[:id]
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_contact_messages_path, notice: 'Unable to find that contact message.'
  end
end
