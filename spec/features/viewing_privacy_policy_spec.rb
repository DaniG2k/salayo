RSpec.describe 'Viewing the Privacy Policy page', type: :feature do
  it 'exists' do
    visit privacy_policy_path

    expect(current_path).to eq '/privacy_policy'
    expect(page.title).to have_content 'Privacy Policy'
  end
end
