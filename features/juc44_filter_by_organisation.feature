Feature: Filter by organisation
#JUC44.1: CE Participant filters People by organisation

  Scenario: CE Participant filters People by organisation
    Given I am on the People page
    When I opt to add a filter
    Then I can choose to filter by organisation
    And opting to filter by organisation will return people within a specific organisation
