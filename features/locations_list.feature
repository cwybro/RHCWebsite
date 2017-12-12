Feature: List locations
  As a resident of Madison Country
  So that I can see outdoor locations near me
  I want to be able to see a list of locations and be able to filter them by distance

Background: The website already has some existing locations.
Given these Users:
    | email                   | password |
    | qvu@colgate.edu         | rhc123   |
And these Locations:
    | title                      | description                   | address                            |
    | Trudy Fitness Center       | A center of fitness           | Trudy Fitness Center, Hamilton, NY |
    | Colgate University         | A University of Colgate       | 13 Oak Drive, Hamilton, NY         |
    | Donovan's Pub              | The pub that the Donovans own | 13 Oak Drive, Hamilton, NY         |
    | Cazenovia Recreation Center| Hiking area                   | 22 Burton St, Cazenovia, NY 13035  |

Scenario: Filter locations by distance
  When I go to the locations page
  And I fill in "Within" with "10"
  And I fill in "miles of" with "Hamilton. NY"
  And I press "Refine the list of locations"
  Then I should be on the locations page
  And I should see "Trudy Fitness Center"
  But I should not see "Cazenovia Recreation Center"
