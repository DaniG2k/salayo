FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'supersecurep@ss'
    trait :admin do
    	admin true
    end
  end
end
