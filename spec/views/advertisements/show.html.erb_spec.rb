require 'rails_helper'

RSpec.describe "advertisements/show", type: :view do
  before(:each) do
    @advertisement = assign(:advertisement, Advertisement.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
