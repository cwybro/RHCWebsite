require 'rails_helper'

RSpec.describe Location, type: :model do
  it "should be valid if title AND coordinates are set" do
    l = Location.new(title: "Test place", latitude: 50.0000, longitude: 60.0000)
    expect(l.valid?).to eq true
  end

  it "should not be valid if title AND coordinates not set" do
    empty = Location.new()
    title = Location.new(title: "Test place")
    coord = Location.new(latitude: 50.0000, longitude: 60.0000)
    desc = Location.new(description: "Test description")
    expect(empty.valid?).to eq false
    expect(title.valid?).to eq false
    expect(coord.valid?).to eq false
    expect(desc.valid?).to eq false
  end

  it "should be able to add a tag to the tags list of the Event" do
      location = Location.new(title: "Trudy Fiteness Center", latitude: 50.0000, longitude: 60.0000)
      tag = Tag.create!(name: "Indoors")
      location.tags << tag
      expect(location.tags.size).to eq(1)
      expect(location.tags.first.name).to eq("Indoors")
  end

end
