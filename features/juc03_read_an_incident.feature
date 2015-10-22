@JUC3
Feature: JUC3 - Read an incident

  @sit
  Scenario: Participant can read an incident report
    Given I have logged in as "participant A"
    When I find and click on an incident report I would like to read
    Then I can view the incident report

  @JUC3.1 @JUC3.4
  Scenario: Participant views an anonymous incident report
    Given I have logged in as "participant A"
    And I have raised a white incident report anonymously in a private group
    When I have logged in as "participant B"
    Then I can view the anonymous incident report

  @JUC3.2
  Scenario: Author views an anonymous incident report
    Given I have logged in as "participant A"
    And I have raised a white incident report anonymously in a private group
    Then I will be able to view my recently created report

  @JUC3.3
  Scenario: Admin views an anonymous incident report
    Given I have logged in as "participant A"
    And I have raised a white incident report anonymously in a private group
    When I have logged in as "admin"
    Then I as an admin can view the anonymous incident report

  @JUC3.5
  Scenario: Participant attempts to view an Incident Report without required permissions
    Given I have logged in as "participant B"
    And I have raised an amber incident report in a secret group
    When I have logged in as "participant A"
    Then I can not directly access the incident report if I am not in that group

  @JUC3.6
  Scenario: Participant searches for incident report by ID using spotlight search
    Given I have logged in as "participant A"
    And I have raised a white incident report anonymously in a private group
    Then I can search for the incident report by ID and view the incident report

  @JUC3.7
  Scenario: Participant searches for an Incident Report to which they have no access
    Given I have logged in as "participant B"
    And I have raised an amber incident report in a secret group
    When I have logged in as "participant A"
    Then I can not find the incident report in search if I am not in that group
