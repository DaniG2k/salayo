require 'rails_helper'

RSpec.describe 'Viewing the Terms and Conditions page', type: :feature do
  it 'exists' do
    visit terms_path

    expect(current_path).to eq '/terms'
    expect(page.title).to have_content 'Terms & Conditions'
  end
end