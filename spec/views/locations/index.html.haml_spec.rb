require 'rails_helper'

RSpec.describe "index page", type: :feature do
  before :each do
    a= Location.new(:title => "1", :description => "test", :address => "Utica, NY")
    a.lat= 7.698744
    a.lng= -0.593262
    allow(a).to receive(:geocode_address).and_return({lat: 7.698744, lng: -0.593262})
    a.save

    b = Location.new(:title => "2", :description => "test", :address => "Orlando, FL")
    b.lat= 6.434036
    b.lng= 16.501465
    allow(b).to receive(:geocode_address).and_return({lat: 6.434036, lng: 16.501465})
    b.save

    c = Location.new(:title => "3", :description => "test", :address => "Edinburgh, UK")
    c.lat= 42.8270
    c.lng= -75.5446
    allow(c).to receive(:geocode_address).and_return({lat: 42.8270, lng: -75.5446})
    c.save

    d= Location.new(:title => "4", :description => "test", :address => "Seattle, WA")
    d.lat= 35.807790
    d.lng= -5.559082
    allow(d).to receive(:geocode_address).and_return({lat: 35.807790, lng: -5.559082})
    d.save

    visit "/locations"
  end

  it "should do the correct filtering when filtering by distance" do
    fill_in "Within", :with => "100"
    fill_in "miles of", :with => "Hamilton, NY"
    click_button "Refine the list of locations"
    names = page.all(".card-title")
    expect(names.length).to eq(1)

    # visit "/locations"
    # names = []
    # page.all(".cell-title").each { |x| names << x.text }
    # expect(names.length).to eq(1)
    # visit "/locations"
    fill_in "Within", :with => ""
    fill_in "miles of", :with => ""
    click_button "Refine the list of locations"
    names = page.all(".card-title")
    # page.all(".cell-title").each { |x| names << x.text }
    expect(names.length).to eq(4)
  end
end
