class Picture < ApplicationRecord
  # Associations
  belongs_to :imageable, polymorphic: true

  mount_uploader :image, ImageUploader
end
