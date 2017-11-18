require 'rails_helper'

RSpec.describe "event_recaps/index", type: :view do
  before(:each) do
    assign(:event_recaps, [
      EventRecap.create!(
        :attendance => 2,
        :description => "MyText"
      ),
      EventRecap.create!(
        :attendance => 2,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of event_recaps" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
