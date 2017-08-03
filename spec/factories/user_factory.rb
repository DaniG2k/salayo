FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'supersecurep@ss'
    name Faker::Name.name

    trait :admin do
    	admin true
    end
  end
end
