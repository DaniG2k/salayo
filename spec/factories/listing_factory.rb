# == Schema Information
#
# Table name: listings
#
#  id            :integer          not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  property_type :string
#  lat           :float
#  lng           :float
#  user_id       :integer
#  address       :string
#  city          :string
#  state         :string
#  amenities     :text             default([]), is an Array
#  bathrooms     :integer          default(0)
#  bedrooms      :integer          default(0)
#  beds          :integer          default(0)
#  description   :text
#  slug          :string
#

require 'securerandom'

FactoryBot.define do
  factory :listing do
    name SecureRandom.hex
    bedrooms 1
    beds 1
    bathrooms 1
    property_type 'apartment'
    lat 37.517235
    lng 127.047325
    price_cents 10000
  end
end
