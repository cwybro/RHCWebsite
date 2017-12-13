When('I click on the {string} button belonging to the {string} event') do |button_name, event_name|
    match = false
    all('.card').each do |card|
        if card.has_content?(event_name)
            match = true
            within(card) { click_link button_name }
        end
    end
    expect(match).to eq(true)
end



Given('I have an event with id {int}') do |id|
  @event = Event.find(id)
end
