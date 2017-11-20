require 'rails_helper'

RSpec.describe Location, type: :model do
  it "should be valid if title AND address are set" do
    l = Location.new(title: "Test place", address: "13 Oak Drive, Hamilton NY")
    allow(l).to receive(:geocode_address).and_return({lat: 50.0, lng: 50.0}) # stub Geokit
    expect(l.valid?).to eq true
  end

  it "should not be valid if title AND address not set" do
    empty = Location.new()
    title = Location.new(title: "Test place")
    addr = Location.new(address: "Hamilton, NY")
    allow(addr).to receive(:geocode_address).and_return({lat: 50.0, lng: 50.0}) # stub Geokit

    desc = Location.new(description: "Test description")
    expect(empty.valid?).to eq false
    expect(title.valid?).to eq false
    expect(addr.valid?).to eq false
    expect(desc.valid?).to eq false
  end

  it "should be able to add a tag to the tags list of the Event" do
      location = Location.new(title: "Trudy Fiteness Center", lat: 50.0000, lng: 60.0000)
      tag = Tag.create!(name: "Indoors")
      location.tags << tag
      expect(location.tags.size).to eq(1)
      expect(location.tags.first.name).to eq("Indoors")
  end
end
