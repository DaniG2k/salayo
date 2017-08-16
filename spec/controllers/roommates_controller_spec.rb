require 'rails_helper'

RSpec.describe RoommatesController, type: :controller do

  describe "GET #ads" do
    it "returns http success" do
      get :ads
      expect(response).to have_http_status(:success)
    end
  end

end
