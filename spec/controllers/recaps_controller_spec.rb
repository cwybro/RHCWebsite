require 'rails_helper'

RSpec.describe RecapsController, type: :controller do 
  describe "#index and #show suite:" do
    before(:each) do
      @user = create(:user)
      @event = create(:event)
    end

    describe "GET #index" do
      it "should redirect to the events page, since we can't expose all recaps to the public" do
        get :index, :params => {:event_id => @event.id}
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(events_path)
      end
    end

    describe "GET #show" do
      it "should redirect to the events page, since we can't expose individual recap to the public" do
        get :show, :params => {:event_id => @event.id, :id => @event.id}
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(events_path)
      end
    end
  end

  describe "#new and #create suite:" do
    before(:each) do
      # See factories.rb
      @user = create(:user)
      @event = create(:event)
    end

    describe "GET #new" do
      it "should redirect to the login page if the user is not logged in" do
        get :new, :params => {:event_id => @event.id}
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should return http success with valid event_id and user permission" do
        login_with @user
        get :new, :params => {:event_id => @event.id}
        expect(response).to have_http_status(:success)
      end

      it "should redirect to the event's page if the user does not have permisison" do
        login_with create(:user, :wrong_user)
        get :new, :params => {:event_id => @event.id}
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(event_path(@event))
      end

      it "should redirect with invalid event_id" do
        get :new, :params => {:event_id => -1}
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(events_path)
      end
    end

    describe "POST #create" do
      it "should return http success and create a recap associated with an event granted correct permissions" do
        expect {
          post :create, :params => {:event_id => @event.id, :recap => recap_params(@event.id)}
        }.to change(Recap, :count).by(1)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(event_path(@event))
      end

      it "should redirect with invalid event_id" do
        login_with @user
        expect {
          post :create, :params => {:event_id => -1, :recap => recap_params(@event.id)}
        }.to change(Recap, :count).by(0)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(events_path)
      end

      it "should redirect with invalid recap" do
        login_with @user
        expect {
          post :create, :params => {:event_id => 1, :recap => {:attendance => 'acbsdf'}}
        }.to change(Recap, :count).by(0)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_event_recap_path(@event))
      end
    end
  end

  describe "edit and #update suite" do
    before(:each) do
      # See factories.rb
      @user = create(:user)
      @event = create(:event)
      @recap = create(:recap)
    end

    describe "GET #edit" do
      it "should redirect to the login page if the user is not logged in" do
        get :edit, :params => {:event_id => @event.id, :id => @event.id}
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should return http success and show the edit page" do
        login_with @user
        expect(Event).to receive(:find).with("1") {@event}
        get :edit, :params => {:event_id => @event.id, :id => @event.id}
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
      end

      it "should redirect to the event's page if the user does not have sufficient permisison" do
        login_with create(:user, :wrong_user)
        get :edit, :params => {:event_id => @event.id, :id => @event.id} 
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(event_path(@event))
      end

      it "should return http failure on invalid event_id" do
        login_with @user
        get :edit, :params => {:event_id => -1, :id => -1}
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(events_path)
      end
    end

    describe "POST #update" do
      it "should return http success and show the event page" do
        post :update, :params => {:event_id => @event.id, :id => @event.id, :recap => recap_params(@event.id)}
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(event_path(@event))
      end

      it "should return to the edit recap page upon failure to update" do
        post :update, :params => {:event_id => 1, :id => 1, :recap => {:attendance => "asdfasc"}}
        @event.reload
        expect(@event.recap).to eq(@recap)
        expect(response).to redirect_to(edit_event_recap_path(@event))
      end
    end
  end

  private
    def recap_params(event_id)
      return {
        is_reviewed: false,
        event_id: event_id,
        attendance: 100,
        description: 'It was a huge party!'
      }
    end
end
