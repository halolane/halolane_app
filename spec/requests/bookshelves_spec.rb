require 'spec_helper'

describe "Bookshelves" do
  describe "GET /bookshelves" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get bookshelves_path
      response.status.should be(200)
    end
  end
end
