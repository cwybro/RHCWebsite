require 'rails_helper'

RSpec.describe "event_recaps/show", type: :view do
  before(:each) do
    @event_recap = assign(:event_recap, EventRecap.create!(
      :attendance => 2,
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
