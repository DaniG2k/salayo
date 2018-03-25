class SendContactMessageJob < ApplicationJob
  queue_as :low

  def perform(msg_id)
    message = ContactMessage.find(msg_id)

    ContactMessageMailer.dispatch(message).deliver_now
  end
end
