class Listing < ApplicationRecord
  resourcify
  validates(
    :name,
    :property_type,
    :lat,
    :lng,
    presence: true)
  validates :lat, inclusion: (-90..90)
  validates :lng, inclusion: (-180..180)

  belongs_to :owner, optional: true

  PROPERTY_TYPES = %w(apartment house bnb loft cabin villa castle dorm treehouse boat plane rv igloo lighthouse yurt tipi cave island chalet earthhouse hut train tent loft townhouse condominium other).sort.freeze
end
