# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  locale                 :string           default("en")
#

class User < ApplicationRecord
  # Constants
  GENDERS = %i[male female other].freeze

  enum role: %i[admin user owner]
  enum gender: GENDERS
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates :first_name, :last_name, presence: true

  # Associations
  has_many :listings, dependent: :destroy
  has_many :advertisements, dependent: :destroy
  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages

  # Uploaders
  mount_uploader :profile_picture, ProfilePictureUploader

  def full_name
    "#{first_name} #{last_name}"
  end
end
