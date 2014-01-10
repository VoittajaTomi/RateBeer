require 'spec_helper'

describe "styles/index" do
  before(:each) do
    assign(:styles, [
      stub_model(Style),
      stub_model(Style)
    ])
  end

  it "renders a list of styles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
