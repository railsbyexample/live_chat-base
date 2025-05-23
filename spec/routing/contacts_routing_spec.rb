require "rails_helper"

RSpec.describe ContactsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(:get => "/contacts/new").to route_to("contacts#new")
    end

    it "routes to #create" do
      expect(:post => "/contacts").to route_to("contacts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/contacts/1").to route_to("contacts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/contacts/1").to route_to("contacts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/contacts/1").to route_to("contacts#destroy", :id => "1")
    end
  end
end
