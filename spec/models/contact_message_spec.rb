require "rails_helper"

RSpec.describe ContactMessage, :type => :model do
  it 'responds to name, email and body' do
    msg = ContactMessage.new

    expect(msg).to respond_to(:name)
    expect(msg).to respond_to(:email)
    expect(msg).to respond_to(:body)
  end

  it 'takes a hash of attributes' do
    attrs = {
      name: 'stephen',
      email: 'stephen@example.org',
      body: 'kthnxbai'
    }

    msg = ContactMessage.new(attrs)
    expect(msg).to be_valid
  end

  it 'validates attribute presence' do
    msg = ContactMessage.new

    expect(msg).not_to be_valid
  end
end
