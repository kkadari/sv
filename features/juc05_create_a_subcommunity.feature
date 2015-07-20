@JUC5
Feature: JUC5 - Create a Sub-community

  @JUC5.2 @CISP-380
  Scenario Outline: Facilitator creates a new private group
    Given I have opted to create a new group as "admin"
    When I create a "<type>" group
    Then the group is created successfully
    And I am displayed the group overview page

    Examples:
      | type    |
      | private |
      | secret  |

  @JUC5.2 @CISP-380
  Scenario: Participant deletes a private group
    Given I have logged in as "admin"
    And I create a "private" group with content
    When I opt to delete the group
    Then the group is deleted
    And all content created within that group no longer exists
