RSpec.describe 'Viewing the Terms and Conditions page', type: :feature do
  it 'exists' do
    visit terms_path

    expect(current_path).to eq "/#{I18n.locale}/terms"
    expect(page.title).to have_content 'Terms & Conditions'
  end
end
