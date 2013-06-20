require 'spec_helper'

describe "bookshelves/edit" do
  before(:each) do
    @bookshelf = assign(:bookshelf, stub_model(Bookshelf,
      :name => "MyString",
      :user_id => 1,
      :privacy => 1
    ))
  end

  it "renders the edit bookshelf form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bookshelves_path(@bookshelf), :method => "post" do
      assert_select "input#bookshelf_name", :name => "bookshelf[name]"
      assert_select "input#bookshelf_user_id", :name => "bookshelf[user_id]"
      assert_select "input#bookshelf_privacy", :name => "bookshelf[privacy]"
    end
  end
end
