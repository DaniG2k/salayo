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

require 'rails_helper'

RSpec.describe Listing, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
