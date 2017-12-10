require 'rails_helper'

RSpec.describe ManageController, type: :controller do

  describe "GET #index" do

    before(:each) do
     # see factories.rb
     @user = create(:user)
    end

    it "returns http success" do
      login_with @user
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
