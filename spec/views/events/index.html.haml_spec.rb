require 'rails_helper'

RSpec.describe "index page", type: :feature do
  before :each do
    @user = create(:user)

    Event.create(user_id: 1,
                is_reviewed: true,
                title: "5k christmas charity run",
                datetime: DateTime.iso8601('2017-12-25T04:05:06-05:00'),  # require 'date'
                description: "Come and run the christmas 5K to raise money for the Madison Country Rural Health Council",
                address: "Trudy Fitness Center, Hamilton")
    Event.create(user_id: 1,
                is_reviewed: true, 
                title: "Slide down the hill",
                datetime: DateTime.iso8601('2018-01-01T04:05:06-05:00'),  # require 'date'
                description: "Rolling down the hill since 1819",
                address: "Colgate University")
    Event.create(user_id: 1,
                is_reviewed: true,
                title: "Slide down the other hill",
                datetime: DateTime.iso8601('2018-01-01T04:10:06-05:00'),  # same date, different time as above.
                description: "Rolling down the hill since 1819",
                address: "Colgate University")
    Event.create(user_id: 1,
                is_reviewed: true,
                title: "10k around campus",
                datetime: DateTime.iso8601('2018-02-28T04:05:06-05:00'),  # require 'date'
                description: "Come run with us!",
                address: "Colgate University")
    Tag.create(name: "dog-friendly")
    Tag.create(name: "kid-friendly")
    Tag.create(name: "hiking")
    Tag.create(name: "swimming")
    Tag.create(name: "running")

    Tagging.create(tag_id: Tag.first.id,
                  event_id: Event.first.id)
    Tagging.create(tag_id: Tag.last.id,
                  event_id: Event.first.id)
    Tagging.create(tag_id: Tag.first.id,
                  event_id: Event.last.id)

    visit "/events"
  end

  it "should do the correct filtering when filtering by tag" do
    names = page.all(".card-title")
    expect(names.length).to eq(4)

    select "dog-friendly", :from => :tag
    click_button "Refine the list of events"
    names = page.all(".card-title")
    expect(names.length).to eq(2)

    select "running", :from => :tag
    click_button "Refine the list of events"
    names = page.all(".card-title")
    expect(names.length).to eq(1)
  end
end


# RSpec.describe "events/index.html.haml", type: :view do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
