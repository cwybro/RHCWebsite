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

  it "should have an address with valid coordinates" do
    park = Location.new(title: "Triangle Park", latitude: 42.825102, longitude: -75.548332)
    expect(park.reverse_geocode).to eq "10 Montgomery St, Hamilton, NY 13346, USA"
  end

  it "should have a nil address with invalid coordinates" do
    invalid = Location.new(title: "Test place", latitude: -500.0, longitude: -500.0)
    expect(invalid.reverse_geocode).to eq nil
  end

  it "should have a short address with valid coordinates" do
    park = Location.new(title: "Triangle Park", latitude: 42.825102, longitude: -75.548332)
    expect(park.short_address).to eq "Hamilton, NY - 13346"
  end

  it "should have an empty short address with invalid coordinates" do
    invalid = Location.new(title: "Test place", latitude: -500.0, longitude: -500.0)
    expect(invalid.short_address).to eq ""
  end
end
