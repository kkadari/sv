Feature: JUC1 - Establish a Profile

  Scenario: Participant B observes that Participant B has updated their profile
    Given "participant A" has updated their profile
    When I navigate to the feeds page as "participant B"
    Then I am informed that "participant A" has updated their profile

  Scenario: Participant setups their profile and privacy
    Given I have navigated to the edit profile privacy page as "participant A"
    When I make changes to my privacy details and save them
    Then my privacy profile details are updated

  Scenario: Participant setups their profile details
    Given I have navigated to the edit profile page as "participant A"
    When I make changes to my profiles details and save them
    Then my profile details are updated
