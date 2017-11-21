require 'rails_helper'

RSpec.describe LocationsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #show" do
    it "renders the show template with correct id" do
      location = Location.create(title: "Triangle Park",
                                description: "Park fit for families",
                                address: "Triangle Park, Hamilton NY")

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

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
      it "returns http success and creates a location in the db" do
          location_params = {title: "Persson Steps",
                description: "Many steps. Good workout route to classes",
                address: "13 Oak Dr. Hamilton, NY"}
          location = Location.new(location_params)
          expect {
              post :create, :params => {:location => location_params}
          }.to change(Location, :count).by(1)
          expect(response).to have_http_status(:redirect)
          expect(response).to redirect_to(locations_path)
      end
  end

  describe "GET #edit" do
    it "renders the edit template with correct id" do
      location = Location.create(title: "Triangle Park",
                                description: "Park fit for families",
                                address: "Triangle Park, Hamilton NY")
      expect(Location).to receive(:find).with("1") {location}
      get :edit, :params => {:id => 1}
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT #update" do
    it "returns http redirect and modifies a location in the db" do
        location = Location.create(title: "Triangle Park",
                                  description: "Park fit for families",
                                  address: "Triangle Park, Hamilton NY")
        put :update, :params => {:id => location.id, :location => {:title => "New Triangle Park"}}
        location.reload
        expect(location.title).to eq("New Triangle Park")
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(location_url(location))
    end

    it "returns to the edit page after failure to edit location" do
        location = Location.create(title: "Triangle Park",
                                  description: "Park fit for families",
                                  address: "Triangle Park, Hamilton NY")
        put :update, :params => {:id => location.id, :location => {:title => ""}}
        location.reload
        expect(location.title).to eq("Triangle Park")
        expect(response).to redirect_to(edit_location_url(location))
    end
  end

end
