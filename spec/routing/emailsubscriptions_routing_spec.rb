require "spec_helper"

describe EmailsubscriptionsController do
  describe "routing" do

    it "routes to #index" do
      get("/emailsubscriptions").should route_to("emailsubscriptions#index")
    end

    it "routes to #new" do
      get("/emailsubscriptions/new").should route_to("emailsubscriptions#new")
    end

    it "routes to #show" do
      get("/emailsubscriptions/1").should route_to("emailsubscriptions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/emailsubscriptions/1/edit").should route_to("emailsubscriptions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/emailsubscriptions").should route_to("emailsubscriptions#create")
    end

    it "routes to #update" do
      put("/emailsubscriptions/1").should route_to("emailsubscriptions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/emailsubscriptions/1").should route_to("emailsubscriptions#destroy", :id => "1")
    end

  end
end
