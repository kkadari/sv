@JUC41
Feature: JUC41 - Create a group

  @JUC41.1 @quarantine
  Scenario: Admin creates a secret group (rough process outlined here)
     Given I have logged in as "admin"
     When I navigate to the location to create a new group
     And I enter a Name and Description for the group
     And I set the Group Type to Private
     And I expand the Advanced Options and select Both (Activity Page and Overview Page)
     And I set the landing page to the Overview page
     And I Preview the new group
     And I click to Create Group
     And I cancel the Invite People dialogue window
     Then I have created a new Private Group
     And I am displayed the Group Overview page

  @JUC41.2 @CISP-929
  Scenario: Participant cannot create a group
    Given I have logged in as "participant A"
    Then I am not presented with a menu option to create a group
    And I cannot create a group directly

  @JUC41.2 @CISP-973
  Scenario: Participant cannot create a space
    Given I have logged in as "participant B"
    Then I am not presented with a menu option to create a space
    And I cannot create a space directly