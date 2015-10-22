@JUC7
Feature: JUC7 - Delete an incident

  @JUC7.1 @CISP-1547 @wip #Marked WIP until CISP-1547 fixed.
  Scenario: Admin deletes an incident report
    Given I have logged in as "participant A"
    And I have raised a red incident report in a private group
    When I have logged in as "admin"
    Then I can delete the incident report
