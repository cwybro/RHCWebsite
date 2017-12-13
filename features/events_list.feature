Feature: Events list
  As a user
  so that I can share my event with the community
  I want to be able to add a new a event.
  Background: the website already has some existing events
    Given these Users:
      | email                   | password |
      | qvu@colgate.edu         | rhc123   |

    Given these Events:
      | title                    | description                      | address            | datetime                                      | user_id | is_reviewed |
      | 10k around campus        | Come run with us!                | Colgate University | DateTime.iso8601('2018-01-01T04:05:06-05:00') | 1       | true        |
      | Slide Down the hill      | Sliding down the hill since 1819 | Hamilton, NY       | DateTime.iso8601('2018-02-28T04:05:06-05:00') | 1       | true        |
      | Brisk walk around campus | Come walk with us!               | Colgate University | DateTime.iso8601('2018-02-14T04:05:06-05:00') | 1       | true        |

    Given these Tags:
      | name          |
      | running       |
      | dog-friendly  |

    Given these Taggings:
      | tag_id  | event_id|
      | 1       | 2       |
      | 2       | 3       |
      | 1       | 1       |

    Scenario: See events sorted by date
      When I go to the events page
      And I should see "Slide Down the hill"
      Then I should see events sorted by date


    Scenario: Filter events by tag
      When I go to the events page
      When I select "running" from "tag"
      And I press "Refine the list of events"
      Then I should be on the events page
      And I should see "Slide Down the hill"
      But I should not see "Brisk walk around campus"
