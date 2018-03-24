# == Schema Information
#
# Table name: pictures
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  image          :string
#  description    :string
#  imageable_type :string
#  imageable_id   :integer
#

class Picture < ApplicationRecord
  # Associations
  belongs_to :imageable, polymorphic: true

  mount_uploader :image, ImageUploader

  # Validations
  validates :image, presence: true
  validates_integrity_of :image
end
