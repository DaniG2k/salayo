require 'rails_helper'

RSpec.describe "advertisements/index", type: :view do
  before(:each) do
    assign(:advertisements, [
      Advertisement.create!(),
      Advertisement.create!()
    ])
  end

  it "renders a list of advertisements" do
    render
  end
end
