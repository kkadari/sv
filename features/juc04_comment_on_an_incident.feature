@JUC4
Feature: JUC4 - Comment on an incident

  @JUC4.1 @CISP-336 @manual
  Scenario: Participant mentions another user in a comment on an Incident Report
    Given I have logged in as "participant A"
    And I view an existing incident report
    And I mention "participant B" in a normal comment on the incident report
    When I have logged in as "participant B"
    And I navigate to my inbox
    Then I have received a notification that I was mentioned in an incident report.
    And the notification is attributed to "participant A"

  @JUC4.2 @CISP-259
  Scenario: Participant view anonymous mention in inbox
    Given I have logged in as "participant A"
    And I have quickly raised a white incident report anonymously in a private group
    And I have mentioned "participant B" in an anonymous comment
    When I have logged in as "participant B"
    Then my inbox shows I have been mentioned anonymously

  @JUC4.3 @CISP-335 @manual
  Scenario: Participant mentions another user in a comment on an Incident Report
    Given I have logged in as "participant A"
    And I view an existing incident report
    And I mention "participant B" in a anonymous comment on the incident report
    When I have logged in as "participant B"
    And I navigate to my inbox
    Then I have received a notification that I was mentioned in an incident report.
    And the notification is attributed to "Anonymous"

  @JUC4.4 @CISP-187
  Scenario: Participant reviews an incident report anonymously
    Given I have logged in as "participant A"
    When I have quickly raised a white incident report anonymously in a private group
    Then I can review the incident report anonymously

  @CISP-961
  Scenario: Participant reviews an incident report
    Given I have logged in as "participant A"
    When I have quickly raised a white incident report in a private group
    Then I can review the incident report

  @CISP-186
  Scenario: Participant comments on an incident report anonymously
    Given I have logged in as "participant A"
    When I have quickly raised a white incident report anonymously in a private group
    Then I can comment on the incident report anonymously

  @CISP-960
  Scenario: Participant comments on an incident report
    Given I have logged in as "participant A"
    When I have quickly raised a white incident report anonymously in a private group
    Then I can comment on the incident report
