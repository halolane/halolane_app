require 'spec_helper'

describe "emailsubscriptions/edit" do
  before(:each) do
    @emailsubscription = assign(:emailsubscription, stub_model(Emailsubscription))
  end

  it "renders the edit emailsubscription form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => emailsubscriptions_path(@emailsubscription), :method => "post" do
    end
  end
end
