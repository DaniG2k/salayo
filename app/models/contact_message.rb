class ContactMessage
  include ActiveModel::Model
  attr_accessor :name, :email, :body

  # Validations
  validates :name, :email, :body, presence: true
end
