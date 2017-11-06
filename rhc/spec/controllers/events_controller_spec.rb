require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "renders the show template with correct id" do
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
end
