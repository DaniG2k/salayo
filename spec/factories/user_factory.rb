FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'supersecurep@ss'
    name Faker::Name.name
    locale I18n.available_locales.sample

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
