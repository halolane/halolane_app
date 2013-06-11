require "spec_helper"

describe LikememoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/likememories").should route_to("likememories#index")
    end

    it "routes to #new" do
      get("/likememories/new").should route_to("likememories#new")
    end

    it "routes to #show" do
      get("/likememories/1").should route_to("likememories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/likememories/1/edit").should route_to("likememories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/likememories").should route_to("likememories#create")
    end

    it "routes to #update" do
      put("/likememories/1").should route_to("likememories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/likememories/1").should route_to("likememories#destroy", :id => "1")
    end

  end
end
