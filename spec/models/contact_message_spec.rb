require "rails_helper"

RSpec.describe ContactMessage, :type => :model do
  it 'responds to name, email and body' do
    msg = ContactMessage.new

    expect(msg).to respond_to(:name)
    expect(msg).to respond_to(:email)
    expect(msg).to respond_to(:body)
  end
end
