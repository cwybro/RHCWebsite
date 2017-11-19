require 'rails_helper'

RSpec.describe "recaps/new", type: :view do
  before(:each) do
    assign(:recap, EventRecap.new(
      :attendance => 1,
      :description => "MyText"
    ))
  end

  it "renders new event_recap form" do
    render

    assert_select "form[action=?][method=?]", event_recaps_path, "post" do

      assert_select "input[name=?]", "recap[attendance]"

      assert_select "textarea[name=?]", "recap[description]"
    end
  end
end
