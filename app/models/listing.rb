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

class Listing < ApplicationRecord
  PROPERTY_TYPES = %w[apartment house bnb cabin villa castle dormitory treehouse igloo lighthouse yurt tipi cave island chalet earthhouse hut tent loft townhouse condominium other sharehouse].sort.freeze

  attr_accessor :price_per_month

  extend FriendlyId
  friendly_id :name, use: :slugged

  # Associations
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many :pictures, as: :imageable, dependent: :destroy
  has_one :amenity_list, dependent: :destroy

  # Validations
  validates :name, uniqueness: true
  validates :owner, :name, :bedrooms, :beds, :bathrooms, :property_type, :lat, :lng, presence: true
  validates :lat, numericality: true, inclusion: { in: (-90.0..90.0), message: 'is not in the range -90 to 90' }
  validates :lng, numericality: true, inclusion: { in: (-180.0..180.0), message: 'is not in the range -180 to 180' }
  validates :bedrooms, :bathrooms, :beds, numericality: { only_integer: true }, inclusion: { in: (0..10) }

  monetize :price_cents, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100_000_000
  }

  # Nested attributes
  accepts_nested_attributes_for :amenity_list

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
