require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  describe "#new and #create suite" do
    before(:each) do
      # see factories.rb
      @user = create(:user)
    end

    describe "GET #new" do
      it "redirects to login page if the user is not logged in" do
        get :new
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end

      it "returns http success when the user is logged in" do
        login_with @user 
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST #create" do
      it "return to the create new event page upon invalid information" do
          event_params = {
                user_id: 1,
                title: "15k christmas charity run",
                datetime: "bad input",  # require 'date'
                description: "Come and run the christmas 5K to raise money for the Madison Country Rural Health Council",
                address: "Trudy Fitness Center, Hamilton"}
          expect {
              post :create, :params => {:event => event_params}
          }.to change(Event, :count).by(0)
          expect(response).to have_http_status(:redirect)
          expect(response).to redirect_to(new_event_path)
      end

      it "returns http success and creates an event in the db" do
          expect {
              post :create, :params => {:event => event_params(@user.id)}
          }.to change(Event, :count).by(1)
          expect(response).to have_http_status(:redirect)
          expect(response).to redirect_to(events_path)
      end
    end
  end

  describe "#edit and #update suite" do
    before(:each) do
      @user = create(:user)
      @event = create(:event)
    end

    describe "GET #edit" do
      it "redirects to login page if the user is not logged in" do
        get :edit, :params => {:id => @event.id}
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end

      it "renders the edit template with correct id and correct user permission" do
        login_with @user
        expect(Event).to receive(:find).with("1") {@event}
        get :edit, :params => {:id => @event.id}
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
      end

      it "redirects with incorrect user permission" do
        login_with create(:user, :wrong_user) 
        get :edit, :params => {:id => @event.id}
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(event_path(@event))
      end
    end

    describe "PUT #update" do
      it "returns http redirect and modifies an event in the db" do
        put :update, :params => {:id => @event.id, :event => {:title => "10k run!"}}
        @event.reload
        expect(@event.title).to eq("10k run!")
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(event_url(@event))
      end

      it "returns to the edit page after failure to edit event" do
        put :update, :params => {:id => @event.id, :event => {:datetime => "sadlknasdlknasd"}}
        @event.reload
        expect(@event.datetime).to eq(DateTime.iso8601('2017-12-25T04:05:06-05:00'))
        expect(response).to redirect_to(edit_event_url(@event))
      end
    end

    describe "GET #show" do
      it "renders the show template with correct id" do
        get :show, :params => {:id => @event.id}
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
      end

      it "redirects to index with bad id" do
        get :show, :params => {:id => -1}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(events_path)
      end
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  private 
  def event_params(user_id)
    return {
      user_id: user_id,
      is_reviewed: false,
      title: "5k christmas charity run",
      datetime: DateTime.iso8601('2017-12-25T04:05:06-05:00'),  # require 'date'
      description: "Come and run the christmas 5K to raise money for the Madison Country Rural Health Council",
      address: "Trudy Fitness Center, Hamilton"
    }
  end
end
