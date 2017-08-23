require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe SendContactMessageJob, type: :job do
  it 'job is created' do
    ActiveJob::Base.queue_adapter = :test
    expect{
      ContactMessageMailer.dispatch.deliver_later
    }.to have_enqueued_job.on_queue('mailers')
  end
end
