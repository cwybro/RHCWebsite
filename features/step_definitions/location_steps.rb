When('I click on the {string} button belonging to the {string} location') do |button_name, location_title|
    match = false
    all('.card').each do |card|
        if card.has_content?(location_title)
            match = true
            within(card) { click_link button_name }
        end
    end
    expect(match).to eq(true)
end

Given("I have a location with title {string}") do |title|
    @location = Location.where(title: title).first
end
