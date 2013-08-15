require 'spec_helper'

describe "emailsubscriptions/index" do
  before(:each) do
    assign(:emailsubscriptions, [
      stub_model(Emailsubscription),
      stub_model(Emailsubscription)
    ])
  end

  it "renders a list of emailsubscriptions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
