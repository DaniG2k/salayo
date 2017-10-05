class Advertisement < ApplicationRecord
  ALLOWED_TYPES = %w(rent let wanted).freeze
  
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :user, :title, :body, :ad_type, presence: true
  validates :ad_type, inclusion: { in: ALLOWED_TYPES }

  belongs_to :user
  has_many :pictures, as: :imageable, dependent: :destroy
end
