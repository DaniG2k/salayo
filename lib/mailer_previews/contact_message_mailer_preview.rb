class ContactMessageMailerPreview < ActionMailer::Preview
  def dispatch
    message = ContactMessage.new(
      name: 'Test user',
      email: 'bob@bobby.com',
      body: 'This website is great! Love it :)'
    )
    ContactMessageMailer.dispatch(message)
  end
end
