Feature: Update existing location
  As an admin
  So that I keep my locations up to date
  I want to be able to update location information.

  Background: the website already has some events
  Given I am an admin


  And these Locations:
      | title                      | description                   | address                            |
      | Trudy Fitness Center       | A center of fitness           | Trudy Fitness Center, Hamilton, NY |
      | Colgate University         | A University of Colgate       | 13 Oak Drive, Hamilton, NY         |
      | Donovan's Pub              | The pub that the Donovans own | 13 Oak Drive, Hamilton, NY         |
      | Cazenovia Recreation Center| Hiking area                   | 22 Burton St, Cazenovia, NY 13035  |

  Scenario: Update an existing location
    Given I am on the locations page
    Then I should see "Trudy Fitness Center"
    When I click on the "Details" button belonging to the "Trudy Fitness Center" location
    Then I should see "A center of fitness"
    And I should see "Trudy Fitness Center, Hamilton, NY"
    When I follow "Edit location"
    And I fill in "Description" with "Get ripped"
    And I fill in "Address" with "Vancouver, BC"
    And I press "Update location"
    Then I should see "Get ripped"
    And I should see "Vancouver, BC"
