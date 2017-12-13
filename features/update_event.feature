Feature: Update existing event
  As a host or admin
  So that I keep my events up to date
  I want to be able to update event information.

  Background: the website already has some events
  Given I am an admin


  And these Events:
    | title                    | description                      | address            | datetime                                      | user_id | is_reviewed |
    | 10k around campus        | Come run with us!                | Colgate University | DateTime.iso8601('2018-01-01T04:05:06-05:00') | 1       | true        |
    | Slide Down the hill      | Sliding down the hill since 1819 | Hamilton, NY       | DateTime.iso8601('2018-02-28T04:05:06-05:00') | 1       | true        |
    | Brisk walk around campus | Come walk with us!               | Colgate University | DateTime.iso8601('2018-02-14T04:05:06-05:00') | 1       | true        |

  Scenario: Update an existing event
    Given I am on the events page
    Then I should see "10k around campus"
    When I click on the "Details" button belonging to the "10k around campus" event
    Then I should see "Come run with us!"
    And I should see "Colgate University"
    And I should see "admin@mco.com"
    When I follow "Edit event"
    And I fill in "Description" with "Free t-shirts after the event!"
    And I fill in "Address" with "Boston, MA"
    And I press "Update event details"
    Then I should see "Free t-shirts after the event!"
    And I should see "Boston, MA"
