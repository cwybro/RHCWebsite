Feature: Create a new location 
  As a user/admin
  so that I can introduce people to a new event 
  I want to be able to add a new event.

  Scenario: Try to create a new location without login in
    When I go to the create new event page
    Then I should be on the sign in page
    And I should see "Log in first to create a new event!"

  Scenario: Create a new location with invalid information
    Given I am a normal user
    Given I am on the create new event page
    When I fill in the following:
      | Title          | 5k christmas charity run |
      | Description    | Come and run the christmas 5K to raise money for the Madison Country Rural Health Council |
      | Address        | Trudy Fitness Center, Hamilton |

    Then I should be on the new event page
