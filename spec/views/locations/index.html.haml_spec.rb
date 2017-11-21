require 'rails_helper'

RSpec.describe "index page", type: :feature do
  before :each do
    a= Location.create(:title => "1", :address => "Utica, NY")
    allow(a).to receive(:geocode_address).and_return({lat: 7.698744, lng: -0.593262})
    a.save(:validate=>false)
    b = Location.create(:title => "2", :address => "Orlando, FL")
    allow(b).to receive(:geocode_address).and_return({lat: 6.434036, lng: 16.501465})
    b.save(:validate=>false)
    c = Location.create(:title => "3", :address => "Edinburgh, UK")
    allow(c).to receive(:geocode_address).and_return({lat: 42.8270, lng: -75.5446})
    c.save(:validate=>false)
    d= Location.create(:title => "4", :address => "Seattle, WA")
    allow(d).to receive(:geocode_address).and_return({lat: 35.807790, lng: -5.559082})
    d.save(:validate=>false)

    # allow_any_instance_of(RentalPropertiesHelper).to receive(:geolocate).and_return([42.8270, -75.5446])
    visit "/locations"
  end

  it "should do the correct filtering when filtering by distance" do
    fill_in "Within", :with => "100"
    fill_in "miles of", :with => "Hamilton, NY"
    click_button "Refine the list of locations"
    visit "/locations"
    names = []
    page.all(".title").each { |x| names << x.text }
    expect(names.length).to eq(1)
    visit "/locations"
    names = []
    page.all(".title").each { |x| names << x.text }
    expect(names.length).to eq(1)
    visit "/locations"
    fill_in "Within", :with => ""
    fill_in "miles of", :with => ""
    click_button "Refine the list of locations"
    names = []
    page.all(".title").each { |x| names << x.text }
    expect(names.length).to eq(4)
  end
end
