require "rails_helper"

RSpec.describe RecapsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/recaps").to route_to("recaps#index")
    end

    it "routes to #new" do
      expect(:get => "/recaps/new").to route_to("recaps#new")
    end

    it "routes to #show" do
      expect(:get => "/recaps/1").to route_to("recaps#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/recaps/1/edit").to route_to("recaps#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/recaps").to route_to("recaps#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/recaps/1").to route_to("recaps#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/recaps/1").to route_to("recaps#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/recaps/1").to route_to("recaps#destroy", :id => "1")
    end

  end
end
