Feature: Create a new location 
  As an admin
  so that I can show people a new location for exercising
  I want to be able to add a new location.

  Scenario: Try to create a new location without login in
    When I go to the create new location page
    Then I should be on the locations page
    And I should see "Invalid permissions"

  Scenario: Try to create a new location even without permission
    Given I am a normal user
    When I go to the create new location page
    Then I should be on the locations page
    And I should see "Invalid permissions"

  Scenario: Create a new location with valid credential
    Given I am an admin
    Given I am on the create new location page
    When I fill in the following:
      | Title                     | Triangle Park              |
      | Description               | Hiking area                |
      | Address                   | Triangle Park, Hamilton NY |

    When I press "Create Location" 
    Then I should be on the locations page
    And I should see "New location 'Triangle Park' created"
    And I should see that "Triangle Park" has an address of "Triangle Park, Hamilton NY"
    Then I click "Details"
    And I should be on the location page with id 1
    And I should see that "Triangle Park" has a description of "Hiking area"

  Scenario: Create a new location with invalid information 
    Given I am an admin
    Given I am on the create new location page
    When I fill in the following:
      | Title                     | Triangle Park              |
      | Description               | Hiking area                |

    When I press "Create Location" 
    Then I should be on the new location page
