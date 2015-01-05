@JUC1 @quarantine
Feature: JUC1 - Establish a Profile

  @quarantine @invalid @jus2 @jus2-1
  Scenario: Participant enhances their profile information
    Given I have enhanced my profile
    Then participants that follow me can view the profile enhancements

  @quarantine @invalid @jus2 @jus2-2
  Scenario: Participant restricts aspects of their profile information
    Given I have restricted parts of my profile
    Then followers can see restrictions
    And non followers cannot see restrictions