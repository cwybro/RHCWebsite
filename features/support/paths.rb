# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /the create new rental property page$/
      new_rental_property_path

    when /the rental properties page$/
      rental_properties_path

    when /the show event page/
        event_path(@event)

    when /the show location page/
        location_path(@location)

    when  /^the home page$/
        "/"

    when /^the create new location page$/
        "/locations/new"

    when /^the create new event page$/
        "/events/new"

    when  /^the locations page$/
        "/locations"

    when /^the events page$/
        "/events"

    when /^the location page with id (\d+)$/
        "/locations/#{$1}"

    when /^the sign in page$/
        "/users/sign_in"
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
