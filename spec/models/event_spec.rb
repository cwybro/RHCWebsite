require 'rails_helper'
require 'date'

RSpec.describe Event, type: :model do
    before(:each) do
        @user = create(:user)
    end

    it "should be able to create an Event model with the correct methods on it" do
      ev = Event.create!(
                        user_id: 1,
                        is_reviewed: false,
                        title: "5k chirstmas charity run",
                        datetime: DateTime.iso8601('2017-12-25T04:05:06-05:00'),  # require 'date'
                        description: "Come and run the christmas 5K to raise money for the Madison
                         Country Rural Health Council",
                        address: "Trudy Fitness Center, Hamilton")
      expect(ev).to respond_to(:title)
      expect(ev).to respond_to(:datetime)
      expect(ev).to respond_to(:description)
      expect(ev).to respond_to(:address)
      expect(ev).to respond_to(:date)
      expect(ev).to respond_to(:readable_date)
      expect(ev).to respond_to(:area)
      expect(ev).to respond_to(:time)
    end

    it "should fail to create on invalid/missing information" do
        expect {Event.create!(description: "This will not save")}.to raise_exception ActiveRecord::RecordInvalid
        expect {Event.create!(title: "5k christmas run",
                            description: "the date is missing.",
                            address: "Trudy Fitness center")
                        }.to raise_exception ActiveRecord::RecordInvalid
    end

    it "shouldn't accept strings for datetime" do
        expect {
            Event.create!(user_id: 1,
                        is_reviewed: false,
                        title: "5k chirstmas charity run",
                        datetime: "Sometime last week",
                        description: "Come and run the christmas 5K to raise money for the Madison
                        Country Rural Health Council",
                        address: "Trudy Fitness Center, Hamilton")
            }.to raise_exception ActiveRecord::RecordInvalid
    end

    it "should be able to reduce the address down to its broad area" do
      ev = Event.create!(user_id: 1,
                        is_reviewed: false,
                        title: "5k chirstmas charity run",
                        datetime: DateTime.iso8601('2017-12-25T04:05:06-05:00'),  # require 'date'
                        description: "Come and run the christmas 5K to raise money for the Madison
                        Country Rural Health Council",
                        address: "Trudy Fitness Center, Hamilton")
        expect(ev.area).to eq("Trudy Fitness Center, Hamilton")
        ev = Event.create!(user_id: 1,
                        is_reviewed: false,
                        title: "5k chirstmas charity run",
                        datetime: DateTime.iso8601('2017-12-25T04:05:06-05:00'),  # require 'date'
                        description: "Come and run the christmas 5K to raise money for the Madison
                        Country Rural Health Council",
                        address: "100 broad street, Hamilton, NY 13346")
        expect(ev.area).to eq("Hamilton, NY")
    end

    it "should be able to correctly format the date to a readable format" do
        ev = Event.create!(user_id: 1,
                        is_reviewed: false,
                        title: "5k chirstmas charity run",
                        datetime: DateTime.iso8601('2017-12-25T04:05:06-05:00'),  # require 'date'
                        description: "Come and run the christmas 5K to raise money for the Madison
                        Country Rural Health Council",
                        address: "100 broad street, Hamilton, NY 13346")
        expect(ev.readable_date).to eq("Mon, 25 December 2017")
    end

    it "should correctly format the time of the event" do
        ev = Event.create!(user_id: 1,
                        is_reviewed: false,
                        title: "5k chirstmas charity run",
                        datetime: DateTime.iso8601('2017-12-25T04:05:06-05:00'),  # require 'date'
                        description: "Come and run the christmas 5K to raise money for the Madison
                        Country Rural Health Council",
                        address: "100 broad street, Hamilton, NY 13346")
        expect(ev.time).to eq(" 9.05 AM")
    end

    it "should be able to add a tag to the tags list of the Event" do
        ev = Event.create!(user_id: 1,
                        is_reviewed: false,
                        title: "5k chirstmas charity run",
                        datetime: DateTime.iso8601('2017-12-25T04:05:06-05:00'),  # require 'date'
                        description: "Come and run the christmas 5K to raise money for the Madison
                        Country Rural Health Council",
                        address: "Trudy Fitness Center, Hamilton")
        tag = Tag.create!(name: "Indoors")
        ev.tags << tag
        expect(ev.tags.size).to eq(1)
        expect(ev.tags.first.name).to eq("Indoors")
    end
    it "should collect events from today using the :today scope" do
        today_ev = Event.create!(user_id: 1,
                        is_reviewed: false,
                        title: "5k chirstmas charity run",
                        datetime: DateTime.current(),  # require 'date'
                        description: "Come and run the christmas 5K to raise money for the Madison
                        Country Rural Health Council",
                        address: "100 broad street, Hamilton, NY 13346")
      	expect(Event.today).to eq(Event.where('datetime > ? AND datetime < ?', DateTime.current().beginning_of_day, DateTime.current.end_of_day))
      	num_events_today = Event.today.length
      	expect(num_events_today > 0).to eq(true)
      	today_ev.datetime = Date.today - 2  # two days ago.
      	today_ev.save
      	expect(num_events_today - Event.today.length).to eq(1)
    end

    it "should return appropriate date string for passed and upcoming events" do
      ref = DateTime.now
      ev = Event.create!(user_id: 1,
                      is_reviewed: false,
                      title: "5k chirstmas charity run",
                      datetime: ref,
                      description: "Come and run the christmas 5K to raise money for the Madison
                      Country Rural Health Council",
                      address: "Trudy Fitness Center, Hamilton")
      expect(ev.days_until(ref)).to eq("Today")

      ev.datetime = ref + 1
      expect(ev.days_until(ref)).to eq("Tomorrow")

      ev.datetime = ref + 2
      expect(ev.days_until(ref)).to eq("2 days")

      ev.datetime = ref - 1
      expect(ev.days_until(ref)).to eq("Passed")
    end
end
