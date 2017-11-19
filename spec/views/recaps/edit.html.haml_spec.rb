require 'rails_helper'

RSpec.describe "recaps/edit", type: :view do
  before(:each) do
    @event_recap = assign(:recap, Recap.create!(
      :attendance => 1,
      :description => "MyText"
    ))
  end

  it "renders the edit recap form" do
    render

    assert_select "form[action=?][method=?]", recap_path(@recap), "post" do

      assert_select "input[name=?]", "event_recap[attendance]"

      assert_select "textarea[name=?]", "event_recap[description]"
    end
  end
end
