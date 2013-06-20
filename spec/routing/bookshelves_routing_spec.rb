require "spec_helper"

describe BookshelvesController do
  describe "routing" do

    it "routes to #index" do
      get("/bookshelves").should route_to("bookshelves#index")
    end

    it "routes to #new" do
      get("/bookshelves/new").should route_to("bookshelves#new")
    end

    it "routes to #show" do
      get("/bookshelves/1").should route_to("bookshelves#show", :id => "1")
    end

    it "routes to #edit" do
      get("/bookshelves/1/edit").should route_to("bookshelves#edit", :id => "1")
    end

    it "routes to #create" do
      post("/bookshelves").should route_to("bookshelves#create")
    end

    it "routes to #update" do
      put("/bookshelves/1").should route_to("bookshelves#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/bookshelves/1").should route_to("bookshelves#destroy", :id => "1")
    end

  end
end
