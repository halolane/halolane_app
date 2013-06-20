require 'spec_helper'

describe "bookshelves/new" do
  before(:each) do
    assign(:bookshelf, stub_model(Bookshelf,
      :name => "MyString",
      :user_id => 1,
      :privacy => 1
    ).as_new_record)
  end

  it "renders new bookshelf form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bookshelves_path, :method => "post" do
      assert_select "input#bookshelf_name", :name => "bookshelf[name]"
      assert_select "input#bookshelf_user_id", :name => "bookshelf[user_id]"
      assert_select "input#bookshelf_privacy", :name => "bookshelf[privacy]"
    end
  end
end
