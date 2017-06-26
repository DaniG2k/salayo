class ContactMessagesController < ApplicationController
  def new
    @message = ContactMessage.new
  end

  def create
    @message = ContactMessage.new(contact_message_params)

    if @message.valid?
      redirect_to new_message_path, notice: 'Message received, thanks!'
    else
      render :new
    end
  end

  private
    def contact_message_params
      params.require(:contact_message).permit(:name, :email, :body)
    end
end
