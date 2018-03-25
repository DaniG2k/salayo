class ContactMessagesController < ApplicationController
  def new
    @message = ContactMessage.new
  end

  def create
    @message = ContactMessage.new(contact_message_params)

    if @message.save
      SendContactMessageJob.perform_later(@message.id)
      redirect_to new_contact_message_path, notice: I18n.t('contact_message_mailer.message_received')
    else
      render :new
    end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(
      :name,
      :email,
      :body
    )
  end
end
