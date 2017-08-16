require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}

  before do
    allow(controller).to receive(:authenticate_user!)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {id: user.id, locale: user.locale}
      
      expect(response).to have_http_status(:success)
    end
  end

end
