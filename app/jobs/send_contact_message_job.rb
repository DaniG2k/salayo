class SendContactMessageJob < ApplicationJob
  queue_as :low

  def perform(msg)
    ContactMessageMailer.dispatch(msg).deliver!#.deliver_later
  end
end
