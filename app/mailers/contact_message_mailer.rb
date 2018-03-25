class ContactMessageMailer < ApplicationMailer
  default to: ENV['ADMIN_EMAIL']

  def dispatch(msg)
    @message = msg
    mail(
      from: @message.email,
      subject: I18n.t('contact_message_mailer.dispatch.subject')
    )
  end
end
