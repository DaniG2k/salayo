require 'rails_helper'

RSpec.describe ListingsController, type: :controller do
  it 'handles permission errors by redirecting to a safe place' do
    allow(controller).to receive(:current_user)

    listing = FactoryGirl.create(:listing)
    get :edit, params: {id: listing}

    expect(response).to redirect_to(dashboard_path)
    message = 'You are not allowed to access that resource.'
    expect(flash[:warning]).to eq(message)
  end
end
