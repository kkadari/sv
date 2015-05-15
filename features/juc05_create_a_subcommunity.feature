@JUC5
Feature: JUC5 - Create a Sub-community

  @JUC5.2 @CISP-380 @manual
  Scenario: Facilitator creates a new private group
    Given I have logged in as "Facilitator A"
    And I select to create a new group
    And I enter basic group information
    And I expand the Advanced options for the group creation form
    And I set the Group Type to Private
    And I select to include all necessary Group Features
    When I submit the group creation form
    Then I the group is created successfully
    And I am displayed the Group Overview page

  @JUC5.2 @CISP-411 @manual
  Scenario: Facilitator creates a new secret group
    Given I have logged in as "Facilitator A"
    And I select to create a new group
    And I enter basic group information
    And I expand the Advanced options for the group creation form
    And I set the Group Type to Secret
    And I select to include all necessary Group Features
    When I submit the group creation form
    Then I the group is created successfully
    And I am displayed the Group Overview page
