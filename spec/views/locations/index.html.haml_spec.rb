require 'rails_helper'

RSpec.describe "index page", type: :feature do
  before :each do
    a= Location.new(:title => "1",
                    :description => "Test",
                    :address => "Utica, NY")
    allow(a).to receive(:geocode_address).and_return({lat: 43.101356, lng: -75.227759})
    a.save

    b = Location.new(:title => "2",
                     :description => "Test",
                     :address => "Orlando, FL")
    allow(b).to receive(:geocode_address).and_return({lat: 28.485321, lng: -81.383864})
    b.save

    c = Location.new(:title => "3",
                     :description => "Test",
                     :address => "Edinburgh, UK")
    allow(c).to receive(:geocode_address).and_return({lat: 55.944974, lng: -3.181998})
    c.save

    d= Location.new(:title => "4",
                    :description => "Test",
                    :address => "Seattle, WA")
    allow(d).to receive(:geocode_address).and_return({lat: 47.632605, lng: -122.364678})
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
