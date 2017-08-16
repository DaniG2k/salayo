class Advertisement < ApplicationRecord
  ALLOWED_TYPES = %w(rent let wanted).freeze

  validates :user, :title, :body, :ad_type, presence: true
  validates :ad_type, inclusion: { in: ALLOWED_TYPES }

  belongs_to :user
end
