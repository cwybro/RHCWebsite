require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

Given /^I am an admin$/ do
  email = 'admin@mco.com'
  password = 'mcoF2017'
  User.new(:email => email, :password => password, :admin => true).save!

  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Log in"
end

Given /^I am a normal user$/ do
  email = 'user@mco.com'
  password = 'mcoF2017'
  User.new(:email => email, :password => password, :admin => false).save!

  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Log in"
end

Given /^(?:|I )am on (.+)$/ do |page_name|
    visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
    current_path = URI.parse(current_url).path
    if current_path.respond_to? :should
        current_path.should == path_to(page_name)
    else
        assert_equal path_to(page_name), current_path
    end
end
  
When /^(?:|I )fill in the following:$/ do |fields|
    fields.rows_hash.each do |name, value|
        fill_in(name, :with => value)
    end
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
    if page.respond_to? :should
        page.should have_content(text)
    else
        assert page.has_content?(text)
    end
end

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
    regexp = Regexp.new(regexp)

    if page.respond_to? :should
        page.should have_xpath('//*', :text => regexp)
    else
        assert page.has_xpath?('//*', :text => regexp)
    end
end

Then /^(?:|I )should see that "(.+)" has an address of "(.+)"$/ do |property, description|
  found = false
  find_all('div.card-body').each do |div|
    if div.find('p').text == description && div.find('h4').text == property
      found = true
      break
    end
  end
  expect(found).to be true
end

Then /^(?:|I )should see that "(.+)" has a description of "(.+)"$/ do |property, description|
  current_div = find_all('div.col-6')[0]
  expect(current_div.find_all('div.header')[0].text).to eq "Triangle Park"
  expect(current_div.find_all('div.section-subtitle')[1].text).to eq "Hiking area"
end

When /^(?:|I )press "([^"]*)"$/ do |button|
    click_button(button)
end

When /^(?:|I )click "([^"]*)"$/ do |tag|
    click_link(tag)
end
