require 'rails_helper'

RSpec.describe RecapsController, type: :controller do 

  describe "GET #new" do
    it "should return http success with valid event_id" do
      event = create_event
      get :new, :params => {:event_id => 1}
      expect(response).to have_http_status(:success)
    end

    it "should redirect with invalid event_id" do
      get :new, :params => {:event_id => 1}
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(events_path)
    end
  end

  describe "POST #create" do
    it "should return http success and create a recap associated with an event" do
      event = create_event
      expect {
        post :create, :params => {:event_id => 1, :recap => recap_params}
      }.to change(Recap, :count).by(1)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(event_path(event))
    end

    it "should redirect with invalid event_id" do
      expect {
        post :create, :params => {:event_id => 2, :recap => recap_params}
      }.to change(Recap, :count).by(0)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(events_path)
    end

    it "should redirect with invalid recap" do
      event = create_event
      expect {
        post :create, :params => {:event_id => 1, :recap => {:attendance => 'acbsdf'}}
      }.to change(Recap, :count).by(0)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(new_event_recap_path(event))
    end

  end

  describe "GET #edit" do
    it "should return http success and show the edit page" do
      event = create_event
      recap = create_recap
      event.recap = recap
      expect(Event).to receive(:find).with("1") {event}
      get :edit, :params => {:event_id => 1, :id => 1}
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end

    it "should return http failure on invalid event_id" do
      event = create_event
      recap = create_recap
      event.recap = recap
      get :edit, :params => {:event_id => 2, :id => 1}
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(events_path)
    end
  end

  describe "POST #update" do
    it "should return http success and show the event page" do
      event = create_event
      recap = create_recap
      event.recap = recap
      post :update, :params => {:event_id => 1, :id => 1, :recap => recap_params}
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(event_path(event))
    end

    it "should return to the edit recap page upon failure to update" do
      event = create_event
      recap = create_recap
      event.recap = recap
      post :update, :params => {:event_id => 1, :id => 1, :recap => {:attendance => "asdfasc"}}
      event.reload
      expect(event.recap).to eq(recap)
      expect(response).to redirect_to(edit_event_recap_path(event))
    end
  end

  private
    def event_params
      return {
        title: "5k christmas charity run",
        datetime: DateTime.iso8601('2017-12-25T04:05:06-05:00'), 
        description: "Come and run the christmas 5K to raise money for the Madison Country Rural Health Council",
        address: "Trudy Fitness Center, Hamilton"
      }
    end

    def recap_params
      return {
        attendance: 100,
        description: "It was a big party!"
      }
    end

    def create_event
      Event.create(event_params)
    end

    def create_recap
      Recap.create(recap_params)
    end
end
