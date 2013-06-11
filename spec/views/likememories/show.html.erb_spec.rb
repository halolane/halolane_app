require 'spec_helper'

describe "likememories/show" do
  before(:each) do
    @likememory = assign(:likememory, stub_model(Likememory,
      :user_id => 1,
      :memory_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
