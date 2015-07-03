@JUC1.1 @JUC1.1 @CISP-355 @manual
Feature: JUC1 - Establish a Profile

  Scenario: Participant B observes that Participant B has updated their profile
    Given "participant A" has updated their profile
    And I have logged in as "participant B"
    When I navigate to the feeds page
    Then I am informed that "participant A" has updated their profile

  Scenario: Participant setups their profile and privacy
    Given I have logged in as "participant A"
    And I navigate to the edit profile privacy page
    When I make changes to my privacy details and save them
    Then my privacy profile details are updated

  Scenario: Participant setups their profile details
    Given I have logged in as "participant A"
    And I navigate to the edit profile page
    When I make changes to my profiles details and save them
    Then my profile details are updated
