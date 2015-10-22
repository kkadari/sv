@sit
Feature: TBC view space

  Scenario: Participant can view a group
    Given I have logged in as "participant A"
    When I find and click on a group I would like to access
    Then the group is displayed to me

  Scenario: Participant can view a space
    Given I have logged in as "participant A"
    When I find and click on a space I would like to access
    Then the space is displayed to me
