require 'spec_helper'

describe "emailsubscriptions/new" do
  before(:each) do
    assign(:emailsubscription, stub_model(Emailsubscription).as_new_record)
  end

  it "renders new emailsubscription form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => emailsubscriptions_path, :method => "post" do
    end
  end
end
