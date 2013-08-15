require 'spec_helper'

describe "emailsubscriptions/show" do
  before(:each) do
    @emailsubscription = assign(:emailsubscription, stub_model(Emailsubscription))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
