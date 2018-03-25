FactoryBot.define do
  factory :contact_message do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    body 'Test email message :)'
  end
end
