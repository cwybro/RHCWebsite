require 'rails_helper'

RSpec.describe LocationsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "renders the show template with correct id" do
      location = Location.create(title: "Triangle Park",
                                description: "Park fit for families",
                                latitude: 50.0,
                                longitude: 50.0)
      expect(Location).to receive(:find).with("1") {location}
      get :show, :params => { :id => 1}
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end

    it "redirects to index with bad id" do
      get :show, :params => { :id => 2}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(locations_path)
    end
  end

end
