Feature: Show an Event
  As a site visitor
  So that I can see more detail of an event listed on the website
  I want to be able to view an event page.

  Background: The website already has some existing events (upcoming and past).
  Given these Users:
      | email                   | password |
      | qvu@colgate.edu         | rhc123   |

  And these Events:
    | title                    | description                      | address            | datetime                                      | user_id | is_reviewed |
    | 10k around campus        | Come run with us!                | Colgate University | DateTime.iso8601('2018-01-01T04:05:06-05:00') | 1       | true        |
    | Slide Down the hill      | Sliding down the hill since 1819 | Hamilton, NY       | DateTime.iso8601('2018-02-28T04:05:06-05:00') | 1       | true        |
    | Brisk walk around campus | Come walk with us!               | Colgate University | DateTime.iso8601('2018-02-14T04:05:06-05:00') | 1       | true        |

  Scenario: User locates an Event show page from the Event Index page
    Given I am on the events page
    Then I should see "Upcoming Events"
    And I should see "Slide Down the hill"
    When I click on the "Details" button belonging to the "Slide Down the hill" event
    Then I should see "Back to list of events"
      And I should see "Slide Down the hill"

  Scenario: Normal user can see all relevant information for a given event
    Given I have an event with id 2
    And I am on show event page
    Then I should see "Slide Down the hill"
      And I should see "Back to list of events"
      And I should see "Sliding down the hill since 1819"
      And I should see "Hamilton, NY"
      And I should see "qvu@colgate.edu"
