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
    it "returns http success with admin user" do
      login_with create(:user, :admin)
      get :new
      expect(response).to have_http_status(:success)
    end

    it "redirects to locations path with regular user" do
      login_with create(:user)
      get :new
      expect(response).to redirect_to(locations_path)
    end

    it "redirects to locations with no user" do
      get :new
      expect(response).to redirect_to(locations_path)
    end
  end

  describe "POST #create" do
      it "returns http success and creates a location in the db for admin" do
        login_with create(:user, :admin)
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

      it "does not create new location and redirects to locations if not admin" do
        location_params = {title: "Persson Steps",
              description: "Many steps. Good workout route to classes",
              address: "13 Oak Dr. Hamilton, NY"}
        location = Location.new(location_params)
        expect {
            post :create, :params => {:location => location_params}
        }.to change(Location, :count).by(0)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(locations_path)
      end

      it "does not create invalid location and redirects to locations if admin" do
        login_with create(:user, :admin)
        location_params = {title: "Persson Steps"}
        expect {
            post :create, :params => {:location => location_params}
        }.to change(Location, :count).by(0)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_location_path)
        expect(flash[:warning]).to eq("Error creating new location")
      end
  end
end
