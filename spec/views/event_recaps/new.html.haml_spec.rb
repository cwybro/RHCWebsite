require 'rails_helper'

RSpec.describe "event_recaps/new", type: :view do
  before(:each) do
    assign(:event_recap, EventRecap.new(
      :attendance => 1,
      :description => "MyText"
    ))
  end

  it "renders new event_recap form" do
    render

    assert_select "form[action=?][method=?]", event_recaps_path, "post" do

      assert_select "input[name=?]", "event_recap[attendance]"

      assert_select "textarea[name=?]", "event_recap[description]"
    end
  end
end
