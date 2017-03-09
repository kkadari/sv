@JUC21
Feature: JUC21 - Read a discussion

  @JUC21.1 @sit @wip @CISP-2440
  Scenario: Participant can read a discussion
    Given I have logged in as "participant A"
    When I find and click on a discussion I would like to read
    Then I can view the discussion

  @JUC21.2 @JUC21.3
  Scenario: Participant views an amber anonymous discussion
  	Given I have logged in as "participant A"
    And I have created an amber discussion anonymously in a private group
    When I have logged in as "participant B"
    Then I can locate and view the anonymous discussion

  @JUC21.4
  Scenario: Admin views an amber anonymous discussion
    Given I have logged in as "participant A"
    And I have created an amber discussion anonymously in a private group
    When I have logged in as "admin"
    Then as an admin I can view the anonymous discussion

  @JUC21.6
  Scenario: Participant attempts to view a Discussion that is not available
    Given I have logged in as "participant A"
    When I attempt to view a discussion that has recently been deleted
    Then the system displays a 'Not Found' error message
