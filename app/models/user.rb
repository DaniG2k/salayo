class User < ApplicationRecord
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  has_many :listings, dependent: :destroy
  has_many :advertisements, dependent: :destroy
end
