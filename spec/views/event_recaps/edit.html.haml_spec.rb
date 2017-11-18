require 'rails_helper'

RSpec.describe "event_recaps/edit", type: :view do
  before(:each) do
    @event_recap = assign(:event_recap, EventRecap.create!(
      :attendance => 1,
      :description => "MyText"
    ))
  end

  it "renders the edit event_recap form" do
    render

    assert_select "form[action=?][method=?]", event_recap_path(@event_recap), "post" do

      assert_select "input[name=?]", "event_recap[attendance]"

      assert_select "textarea[name=?]", "event_recap[description]"
    end
  end
end
