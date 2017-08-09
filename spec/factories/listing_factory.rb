require 'securerandom'

FactoryGirl.define do
  factory :listing do
    name {SecureRandom.hex}
    property_type 'apartment'
    lat 37.517235
    lng 127.047325
  end
end
