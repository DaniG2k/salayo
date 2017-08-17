require 'rails_helper'

RSpec.describe "advertisements/new", type: :view do
  before(:each) do
    assign(:advertisement, Advertisement.new())
  end

  it "renders new advertisement form" do
    render

    assert_select "form[action=?][method=?]", advertisements_path, "post" do
    end
  end
end
