require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end


  describe "GET #edit" do
    it "renders the edit template with correct id" do
      event = Event.create(title: "5k christmas charity run",
            datetime: DateTime.iso8601('2017-12-25T04:05:06-05:00'),  # require 'date'
            description: "Come and run the christmas 5K to raise money for the Madison Country Rural Health Council",
            address: "Trudy Fitness Center, Hamilton")
      expect(Event).to receive(:find).with("1") {event}
      get :edit, :params => { :id => 1}
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
      it "returns http success and creates an event in the db" do
          event_params = {title: "15k christmas charity run",
                datetime: DateTime.iso8601('2017-12-25T04:05:06-05:00'),  # require 'date'
                description: "Come and run the christmas 5K to raise money for the Madison Country Rural Health Council",
                address: "Trudy Fitness Center, Hamilton"}
          event = Event.new(event_params)
          expect {
              post :create, :params => {:event => event_params}
          }.to change(Event, :count).by(1)
          expect(response).to have_http_status(:redirect)
      end
  end

  describe "GET #show" do
    it "renders the show template with correct id" do
      event = Event.create(title: "5k christmas charity run",
            datetime: DateTime.iso8601('2017-12-25T04:05:06-05:00'),  # require 'date'
            description: "Come and run the christmas 5K to raise money for the Madison Country Rural Health Council",
            address: "Trudy Fitness Center, Hamilton")
      expect(Event).to receive(:find).with("1") {event}
      get :show, :params => { :id => 1}
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end

    it "redirects to index with bad id" do
      get :show, :params => { :id => 2}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(events_path)
    end
  end
end
