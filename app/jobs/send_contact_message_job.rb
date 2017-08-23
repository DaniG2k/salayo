class SendContactMessageJob < ApplicationJob
  queue_as :low

  def perform(msg)
    ContactMessageMailer.dispatch(msg).deliver!
  end
end
