class SendContactMessageJob < ApplicationJob
  queue_as :low

  def perform(message)
    ContactMessageMailer.dispatch(message).deliver_now
  end
end
