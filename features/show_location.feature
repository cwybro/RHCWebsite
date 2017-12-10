Feature: Show a location
    As a resident of Madison County
    So that I can view more details about a location
    I want to be a be able to see a page about a location that displays it's information in detail

    Background: The website already has some existing locations.
    Given these Users:
        | email                   | password |
        | qvu@colgate.edu         | rhc123   |
    And these Locations:
        | title                   | description                   | address                     |
        | Trudy Fitness Center    | A center of fitness           | Trudy Fitness Center, Hamilton, NY |
        | Colgate University      | A University of Colgate       | 13 Oak Drive, Hamilton, NY  |
        | Donovan's Pub           | The pub that the Donovans own | 13 Oak Drive, Hamilton, NY  |

    Scenario: User can navigate from location index view to show location page
        Given I am on the locations page
        And I should see "Colgate University"
        And I should see "Trudy Fitness Center"
        When I click on the "Details" button belonging to the "Trudy Fitness Center" location
        Then I should see "Back to locations"
        And I should see "Trudy Fitness Center"

    Scenario: User can view a location show page in full detail, including a google map
        Given I have a location with title "Colgate University"
        And I am on the show location page
        Then I should see "Colgate University"
        And I should see "A University of Colgate"
        And I should see "13 Oak Drive, Hamilton, NY"
        And I should see 1 "iframe"
