class ContactMessage < ApplicationRecord
  # Validations
  validates :name, :email, :body, presence: true
end
