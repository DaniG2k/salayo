class Advertisement < ApplicationRecord
  validates :user, :body, :ad_type, presence: true

  belongs_to :user
end
