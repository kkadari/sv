@JUC16
Feature: JUC16 - Create a poll

  @JUC16.1
  Scenario: Participant creates a poll in the community
  	Given I have logged in as "participant A"
    And I have created an green poll in the community
    When I have logged in as "participant B"
    Then I can vote on the poll

  @JUC16.3
  Scenario: Participant creates a poll in a private group
  	Given I have logged in as "participant A"
    And I have created an amber poll in a private group
    When I have logged in as "participant B"
    Then I can vote on the poll

  @JUC16.3
  Scenario: Participant creates a poll in a space
  	Given I have logged in as "participant A"
    And I have created an amber poll in a space
    When I have logged in as "participant B"
    Then I can vote on the poll
