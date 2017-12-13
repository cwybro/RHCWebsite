Feature: Create a new location 
  As a user/admin
  so that I can introduce people to a new event 
  I want to be able to add a new event.

  Scenario: Try to create a new event without login in
    When I go to the create new event page
    Then I should be on the sign in page
    And I should see "Log in first to create a new event!"

  Scenario: Create a new event with valid information
    Given I am a normal user
    Given I am on the create new event page
    When I fill in the following:
      | Title          | 5k christmas charity run |
      | Description    | Come and run the christmas 5K to raise money for the Madison Country Rural Health Council |
      | Address        | Trudy Fitness Center, Hamilton |
      | Date and Time  | 2018-01-01T04:10:06-05:00 |

    Then I press "Create Event"
    Then I should be on the events page
    And I should see "New event '5k christmas charity run' created"

  Scenario: Create an event with admin account, hence can see the event right away
    Given I am an admin 
    Given I am on the create new event page
    When I fill in the following:
      | Title          | 5k christmas charity run |
      | Description    | Come and run the christmas 5K to raise money for the Madison Country Rural Health Council |
      | Address        | Trudy Fitness Center, Hamilton |
      | Date and Time  | 2018-01-01T04:10:06-05:00 |

    Then I press "Create Event"
    Then I should be on the events page
    And I should see "New event '5k christmas charity run' created"
    And I should see the event "5k christmas charity run"

  Scenario: Create a new with invalid information
    Given I am a normal user
    Given I am on the create new event page
    When I fill in the following:
      | Title          | 5k christmas charity run |
      | Description    | Come and run the christmas 5K to raise money for the Madison Country Rural Health Council |
      | Address        | Trudy Fitness Center, Hamilton |

    And I press "Create Event"
    Then I should be on the new event page
