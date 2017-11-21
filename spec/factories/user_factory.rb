FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'supersecurep@ss'
    #locale I18n.available_locales.sample
    locale 'en'

    trait :owner do
      after(:create) do |instance|
        instance.add_role :owner
      end
    end

    trait :admin do
      after(:create) do |instance|
        instance.add_role :admin
      end
    end
  end
end
