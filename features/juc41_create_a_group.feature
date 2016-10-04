@JUC41 @ui
Feature: JUC41 - Create a group

  @JUC41.2 @cisp
  Scenario: Participant cannot create a group
    Given I have logged in as "participant A"
    Then I am not presented with a menu option to create a group
    And I cannot create a group directly

  @JUC41.2
  Scenario: Participant cannot create a space
    Given I have logged in as "participant B"
    Then I am not presented with a menu option to create a space
    And I cannot create a space directly
