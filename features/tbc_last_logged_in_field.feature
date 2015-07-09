Feature: Last logged in field

  Scenario: Viewing and sorting via the last logged in field
    Given I have logged in as "participant A"
    When I navigate to the list view of people page
    Then I will see the last logged in date for each person
    And I can sort by last logged in date