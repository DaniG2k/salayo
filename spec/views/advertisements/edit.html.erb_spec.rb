require 'rails_helper'

RSpec.describe "advertisements/edit", type: :view do
  before(:each) do
    @advertisement = assign(:advertisement, Advertisement.create!())
  end

  it "renders the edit advertisement form" do
    render

    assert_select "form[action=?][method=?]", advertisement_path(@advertisement), "post" do
    end
  end
end
