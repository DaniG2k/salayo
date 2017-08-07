class Listing < ApplicationRecord
  resourcify
  validates :name, presence: true

  belongs_to :owner, optional: true
end
