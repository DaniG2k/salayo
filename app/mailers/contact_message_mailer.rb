class ContactMessageMailer < ApplicationMailer
  default to: ENV['ADMIN_EMAIL']

  def dispatch(msg)
    @message = msg
    mail(
      from: @message[:email],
      subject: '[Salayo] Contact message received'
    )
  end
end
