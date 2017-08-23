class ContactMessageMailer < ApplicationMailer
  default to: ENV['ADMIN_EMAIL']

  def dispatch(message)
    @message = message
    mail(
      from: @message.email,
      subject: '[Salayo] Contact message received'
    )
  end
end
