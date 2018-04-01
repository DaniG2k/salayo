RSpec.describe User do
  context 'validations' do
    it 'requires a first and last name' do
      valid_user = User.new(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: 's3curep@ss',
        password_confirmation: 's3curep@ss',
        gender: %w(male female).sample
      )
      expect(valid_user).to be_valid

      invalid_user = User.new(
        first_name: '',
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: 's3curep@ss',
        password_confirmation: 's3curep@ss',
        gender: %w(male female).sample
      )
      expect(invalid_user).not_to be_valid
    end
  end
end
