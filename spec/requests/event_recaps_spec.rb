require 'rails_helper'

RSpec.describe "EventRecaps", type: :request do
  describe "GET /event_recaps" do
    it "works! (now write some real specs)" do
      get event_recaps_path
      expect(response).to have_http_status(200)
    end
  end
end
