@JUC10 @manual
Feature: JUC10 - Rate an Incident

  @JUC10.1 @CISP-187 @manual
  Scenario: Participant rates an incident report anonymously
    Given I am viewing an anonymous incident report as "participant A"
    And I have posted a review and rating for the incident
    When I view the incident report as "participant B"
    Then I can view the anonymous review of the incident report
    And the rating is displayed correctly

  @JUC10.1 @CISP-961 @manual
  Scenario: Participant rates an incident report
    Given I am viewing an incident report as "participant A"
    And I have posted a review and rating for the incident
    When I view the incident report as "participant B"
    Then I can view the review of the incident report
    And the rating is displayed correctly


