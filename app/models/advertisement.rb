class Advertisement < ApplicationRecord
  validates :user, :title, :body, :ad_type, presence: true

  belongs_to :user
end
