require 'rails_helper'

RSpec.describe ContactMessagesController, type: :controller do
  describe 'GET new' do
    it 'renders the new template' do
      get :new, params: { locale: 'en' }

      expect(response.status).to eq(200)
    end
  end

  describe 'POST create' do
    it 'creates a contact message' do
      post :create, params: {
        locale: 'en',
        contact_message: {
          name: 'ohai',
          email: 'ohai@example.org',
          body: 'hai'
        }
      }

      expect(response).to redirect_to(new_contact_message_path)
    end
  end
end
