@JUC4
Feature: JUC4 - Comment on an incident

  @JUC4.1 @WIP
  Scenario: Participant mentions another user in a comment on an Incident Report
    Given I have logged in as "participant A"
    And I mention "participant B" in a normal comment on an incident report
    When I navigate to my inbox as "participant B"
    Then I will have received a notification that I was mentioned in an incident report
    And the notification is attributed to "participant A"

  @JUC4.2
  Scenario: Participant view anonymous mention in inbox
    Given I have logged in as "participant A"
    And I have raised a white incident report anonymously in a private group
    And I have mentioned "participant B" in an anonymous comment
    When I have logged in as "participant B"
    Then my inbox shows I have been mentioned anonymously

  @JUC4.4
  Scenario: Participant comments on an incident report anonymously
    Given I have logged in as "participant A"
    When I have raised a white incident report anonymously in a private group
    Then I can comment on the incident report anonymously

  Scenario: Participant comments on an incident report
    Given I have logged in as "participant A"
    When I have raised a white incident report anonymously in a private group
    Then I can comment on the incident report
