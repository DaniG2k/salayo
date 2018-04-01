RSpec.describe 'Registrations' do
  include Warden::Test::Helpers

  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }
  let(:post_valid_attributes) {
    {
      locale: 'en',
      "user" => {
        "first_name" => "Mario",
        "last_name" => "Draghi",
        "email" => "test@user.com",
        "password" => "test1234",
        "password_confirmation" => "test1234",
        "role" => "user",
        "locale" => "en",
        "birth_date" => 20.years.ago,
        "gender" => "",
        "time_zone" => "UTC",
        "biography" => ""
      }
    }
  }
  let(:post_invalid_attributes) {
    {
      locale: 'en',
      "user" => {
        "first_name" => "Mario",
        "last_name" => "Draghi",
        "email" => "test@user.com",
        "password" => "test1234",
        "password_confirmation" => "test1234",
        "role" => "admin",
        "locale" => "en",
        "birth_date" => '',
        "gender" => "",
        "time_zone" => "UTC",
        "biography" => ""
      }
    }
  }
  let(:put_valid_attributes) {
    {
      locale: 'en',
      "user" => {
        "first_name" => user.first_name,
        "last_name" => user.last_name,
        "email" => user.email,
        "current_password" => user.password,
        "role" => "user",
        "locale" => "en",
        "birth_date" => 20.years.ago,
        "gender" => "",
        "time_zone" => "UTC",
        "biography" => "A new biography"
      }
    }
  }
  let(:put_invalid_attributes) {
    {
      locale: 'en',
      "user" => {
        "first_name" => user.first_name,
        "last_name" => user.last_name,
        "email" => user.email,
        "current_password" => user.password,
        "role" => "admin",
        "locale" => "en",
        "birth_date" => 20.years.ago,
        "gender" => "",
        "time_zone" => "UTC",
        "biography" => "A new biography"
      }
    }
  }
  let(:put_admin_invalid_attributes) {
    {
      locale: 'en',
      "user" => {
        "first_name" => admin.first_name,
        "last_name" => admin.last_name,
        "email" => admin.email,
        "current_password" => admin.password,
        "role" => "admin",
        "locale" => "en",
        "birth_date" => 20.years.ago,
        "gender" => "",
        "time_zone" => "UTC",
        "biography" => "A new biography"
      }
    }
  }

  describe "POST /:locale/user" do
    context 'normal users' do
      it "returns success" do
        post user_registration_path(post_valid_attributes)

        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to eq 'Welcome! You have signed up successfully.'
      end

      it 'returns an error if role is set to admin' do
        post user_registration_path(post_invalid_attributes)

        expect(response).not_to redirect_to(dashboard_path)
        expect(User.count).to eq(0)
      end
    end
  end

  describe "PUT /:locale/user" do
    context 'normal users' do
      it "returns success" do
        sign_in user
        # Update user details
        put user_registration_path(put_valid_attributes)

        expect(response).to redirect_to user_path(locale: 'en', id: user.id)
        expect(flash[:notice]).to eq('Your account has been updated successfully.')
      end

      it 'returns an error if role is set to admin' do
        sign_in user
        # Update user details
        put user_registration_path(put_invalid_attributes)

        expect(response).not_to redirect_to(user_path(locale: 'en', id: user.id))
        expect(flash[:error]).to eq('The specified role is invalid.')
      end
    end

    context 'admins' do
      it 'allows PUT role admin' do
        sign_in admin
        # Update admin details
        put user_registration_path(put_admin_invalid_attributes)

        expect(response).to redirect_to(user_path(locale: 'en', id: admin.id))
        expect(flash[:notice]).to eq('Your account has been updated successfully.')
      end
    end
  end
end
