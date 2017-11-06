require 'rails_helper'
require 'date'

RSpec.describe Event, type: :model do
    it "should be able to create an Event model with the correct methods on it" do
      ev = Event.create!(title: "5k chirstmas charity run",
                        datetime: DateTime.iso8601('2017-12-25T04:05:06-05:00'),  # require 'date'
                        description: "Come and run the christmas 5K to raise money for the Madison
                         Country Rural Health Council",
                        address: "Trudy Fitness Center, Hamilton",
                        )
      expect(ev).to respond_to(:title)
      expect(ev).to respond_to(:datetime)
      expect(ev).to respond_to(:description)
      expect(ev).to respond_to(:address)
      expect(ev).to respond_to(:date)
      expect(ev).to respond_to(:time)
    end

    it "should fail to create on invalid/missing information" do
        expect {Event.create!(description: "This will not save")}.to raise_exception ActiveRecord::RecordInvalid
        expect {Event.create!(title: "5k christmas run",
                             description: "the date is missing.",
                             address: "Trudy Fitness center")}.to raise_exception ActiveRecord::RecordInvalid
    end

    it "shouldn't accept strings for datetime" do
        expect { Event.create!(title: "5k chirstmas charity run",
                                datetime: "Sometime last week",
                                description: "Come and run the christmas 5K to raise money for the Madison
                                 Country Rural Health Council",
                                address: "Trudy Fitness Center, Hamilton",
                                ) }.to raise_exception ActiveRecord::RecordInvalid
    end

    it "should be able to add a tag to the tags list of the Event" do
        ev = Event.create!(title: "5k chirstmas charity run",
                          datetime: DateTime.iso8601('2017-12-25T04:05:06-05:00'),  # require 'date'
                          description: "Come and run the christmas 5K to raise money for the Madison
                           Country Rural Health Council",
                          address: "Trudy Fitness Center, Hamilton",
                          )
        tag = Tag.create!(name: "Indoors")
        ev.tags << tag
        expect(ev.tags.size).to eq(1)
        expect(ev.tags.first.name).to eq("Indoors")
    end

end
