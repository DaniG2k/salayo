FactoryBot.define do
  factory :subscription do
    email { Faker::Internet.email }
  end
end
