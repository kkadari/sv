@JUC10 @manual
Feature: JUC10 - Rate an Incident

  @JUC10.1 @CISP-187 @manual
  Scenario: Participant rates an incident report anonymously
    Given I have logged in as "participant A"
    And I have quickly raised a white incident report anonymously in a private group
    When I review the incident report anonymously
    And I have rated the incident report
    And I have logged in as "participant B"
    Then I can view the anonymous review of the incident report
    And the rating is displayed correctly

  @JUC10.1 @CISP-961 @manual
  Scenario: Participant rates an incident report
    Given I have logged in as "participant A"
    And I have quickly raised a white incident report anonymously in a private group
    When I review the incident report
    And I have rated the incident report
    And I have logged in as "participant B"
    Then I can view the review of the incident report
    And the rating is displayed correctly
