require "rails_helper"

RSpec.describe EventRecapsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/event_recaps").to route_to("event_recaps#index")
    end

    it "routes to #new" do
      expect(:get => "/event_recaps/new").to route_to("event_recaps#new")
    end

    it "routes to #show" do
      expect(:get => "/event_recaps/1").to route_to("event_recaps#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/event_recaps/1/edit").to route_to("event_recaps#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/event_recaps").to route_to("event_recaps#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/event_recaps/1").to route_to("event_recaps#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/event_recaps/1").to route_to("event_recaps#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/event_recaps/1").to route_to("event_recaps#destroy", :id => "1")
    end

  end
end
