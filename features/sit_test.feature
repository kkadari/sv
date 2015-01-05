@quarantine
Feature: SIT test

  @quarantine @sit
  Scenario: As a test engineer I want to confirm all content types can be created
    Given I create all the content types
    Then I can view all the created content types as another user

  @quarantine @sit
  Scenario: As a test engineer I want to confirm that I can search for content
    Given all the content types have been created
    Then I can search for all the content types as another user

  @quarantine @sit
  Scenario: As a test engineer I want to confirm that all content types can be edited
    Given all the content types have been created
    Then I can edit all the content types as the author

  @quarantine @sit
  Scenario: As a test engineer I want to confirm that all content types can be deleted by the author
    Given all the content types have been created
    Then I can delete all the content types as the author
    And as an admin I can delete incident reports
