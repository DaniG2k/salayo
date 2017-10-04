class Listing < ApplicationRecord
  PROPERTY_TYPES = %w(apartment house bnb cabin villa castle dorm treehouse igloo lighthouse yurt tipi cave island chalet earthhouse hut tent loft townhouse condominium other).sort.freeze

  resourcify

  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many :pictures, as: :imageable, dependent: :destroy

  validates :name, uniqueness: true
  validates(
    :owner,
    :name,
    :bedrooms,
    :beds,
    :bathrooms,
    :property_type,
    :lat,
    :lng,
    presence: true)
  validates :lat, numericality: true, inclusion: {in: (-90.0..90.0), message: 'is not in the range -90 to 90'}
  validates :lng, numericality: true, inclusion: {in: (-180.0..180.0), message: 'is not in the range -180 to 180'}
  validates :bedrooms, numericality: { only_integer: true }, inclusion: {in: (0..10)}
  validates :beds, numericality: { only_integer: true }, inclusion: {in: (0..10)}
  validates :bathrooms, numericality: { only_integer: true }, inclusion: {in: (0..10)}
end
