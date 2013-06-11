require 'spec_helper'

describe "likememories/index" do
  before(:each) do
    assign(:likememories, [
      stub_model(Likememory,
        :user_id => 1,
        :memory_id => 2
      ),
      stub_model(Likememory,
        :user_id => 1,
        :memory_id => 2
      )
    ])
  end

  it "renders a list of likememories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
