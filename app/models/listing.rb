class Listing < ApplicationRecord
  resourcify

  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  validates :name, uniqueness: true
  validates(
    :owner,
    :name,
    :property_type,
    :lat,
    :lng,
    presence: true)
  validates :lat, inclusion: {in: (-90.0..90.0), message: 'is not in the range -90 to 90'}
  validates :lng, inclusion: {in: (-180.0..180.0), message: 'is not in the range -180 to 180'}

  PROPERTY_TYPES = %w(apartment house bnb cabin villa castle dorm treehouse igloo lighthouse yurt tipi cave island chalet earthhouse hut tent loft townhouse condominium other).sort.freeze
end
