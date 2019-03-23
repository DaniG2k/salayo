# == Schema Information
#
# Table name: advertisements
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  body       :text
#  ad_type    :string
#  title      :string
#  slug       :string
#

class Advertisement < ApplicationRecord
  ALLOWED_TYPES = %w[rent let wanted].freeze

  extend FriendlyId
  friendly_id :title, use: :slugged

  # Validations
  validates :user, :title, :body, :ad_type, presence: true
  validates :ad_type, inclusion: { in: ALLOWED_TYPES }

  # Associations
  belongs_to :user
  has_many :pictures, as: :imageable, dependent: :destroy
end
