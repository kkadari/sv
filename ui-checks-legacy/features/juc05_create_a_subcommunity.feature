@JUC5
Feature: JUC5 - Create a Sub-community

  @JUC5.2 @wip
  Scenario Outline: Facilitator creates a new group
    Given I have opted to create a new group as "admin"
    When I create a "<type>" group
    Then the group is created successfully
    And I am displayed the group overview page

    Examples:
      | type    |
      | private |
      #| secret  | #Pending CISP-2339

  @wip
  Scenario Outline: Participant deletes a group
    Given I have opted to create a new group as "admin"
    When I create a "<type>" group with content
    And I opt to delete the group
    Then the group is deleted
    And all content created within that group no longer exists

    Examples:
      | type    |
      | private |
      #| secret  | #Pending CISP-2339
