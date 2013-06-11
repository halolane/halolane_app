require 'spec_helper'

describe "likememories/new" do
  before(:each) do
    assign(:likememory, stub_model(Likememory,
      :user_id => 1,
      :memory_id => 1
    ).as_new_record)
  end

  it "renders new likememory form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => likememories_path, :method => "post" do
      assert_select "input#likememory_user_id", :name => "likememory[user_id]"
      assert_select "input#likememory_memory_id", :name => "likememory[memory_id]"
    end
  end
end
