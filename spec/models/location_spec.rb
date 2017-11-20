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
end

  describe "distance_within tests" do
  before(:example) do
    l = Location.create(title: "Test place", address: "13 Oak Drive, Hamilton NY")
    allow(l).to receive(:geocode_address).and_return({lat: 42.8166, lng: 75.5402})
    l.save(:validate =>false)
  end

  it "should return false when given a bad location" do
    l= Location.first
    expect(l.distance_within?([nil, nil], 10)).to be false
  end

  it "should return true when given a near-enough location" do
    l = Location.first
    expect(l.distance_within?([42.8166, -75.6000], 100)).to be true
  end

  it "should return false when given a faraway location" do
    l =Location.first
    expect(l.distance_within?([44.184, -69.076], 1)).to be false
  end
end
