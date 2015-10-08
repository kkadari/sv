@manual
Feature: Encrypted / Un-encrypted emails

  Scenario: User disables encrypted notifications in preferences
    Given I have logged in as "participant A"
    And I have disabled encrypted email notifications in preferences
    When I receive a direct message from "participant B"
    Then the email notification will be un-encrypted

  Scenario: User enters a valid PGP key into the profile
    Given I have logged in as "participant A"
    And I navigated to my edit profile page
    When I enter a valid public PGP key into the public PGP key field and save
    Then the key will be validated and saved to the profile

  Scenario: User views another users PGP key in their profile
    Given "participant A" has added a valid public PGP key
    And I have logged in as "participant B"
    When I go to view the profile of "participant A"
    Then I will see the public PGP key for "participant A"

  Scenario: User enables encrypted notifications with a PGP key set
    Given I have logged in as "participant A"
    And I have enabled encrypted email notifications in preferences
    And I have add a valid PGP public key to my profile
    When I receive a direct message from "participant B"
    Then the email notification will be encrypted

  Scenario: User attempts to enter an invalid PGP key
    Given I have logged in as "participant A"
    And I navigated to my edit profile page
    When I enter a invalid public PGP key into the public PGP key field and save
    Then the key will be validated and an error will be returned

  Scenario: User enables encrypted notifications with no PGP key set
    Given I have logged in as "participant A"
    And I have enabled encrypted email notifications in preferences
    And I have deleted my PGP public key from my profile
    When I receive a direct message from "participant B"
    Then the email notification will be un-encrypted