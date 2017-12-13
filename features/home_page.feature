Feature: Home Page
  As a site visitor
  So that I can easily navigate the website
  I want to see event and location content with links to appropriate pages.

  Background: The website already has some existing events and locations.
  Given these Users:
      | email                   | password |
      | qvu@colgate.edu         | rhc123   |
  And these Events:
    | title                    | description                      | address            | datetime                                      | user_id |
    | 10k around campus        | Come run with us!                | Colgate University | DateTime.iso8601('2018-01-01T04:05:06-05:00') | 1       |
    | Slide Down the hill      | Sliding down the hill since 1819 | Hamilton, NY       | DateTime.iso8601('2018-02-28T04:05:06-05:00') | 1       |
    | Brisk walk around campus | Come walk with us!               | Colgate University | DateTime.iso8601('2018-02-14T04:05:06-05:00') | 1       |
  And these Locations:
    | title                      | description                   | address                            |
    | Trudy Fitness Center       | A center of fitness           | Trudy Fitness Center, Hamilton, NY |
    | Colgate University         | A University of Colgate       | 13 Oak Drive, Hamilton, NY         |
    | Donovan's Pub              | The pub that the Donovans own | 13 Oak Drive, Hamilton, NY         |
    | Cazenovia Recreation Center| Hiking area                   | 22 Burton St, Cazenovia, NY 13035  |

  Scenario: User clicks to explore more events
    Given I am on the home page
    Then I should see "Events"
    And I should see "Discover activities"
    When I click on the "Explore" button belonging to the "Events" card
    Then I should be on the events page

  Scenario: User clicks to explore more locations
    Given I am on the home page
    Then I should see "Locations"
    And I should see "Explore new places for hiking, sports, and more"
    When I click on the "Explore" button belonging to the "Locations" event
    Then I should be on the locations page
