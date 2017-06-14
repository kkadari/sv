Feature: TBC - Participant archives a poll

  Scenario: Participant edits an archived poll they authored
    Given I have logged in as "participant A"
    And I have created an amber poll in the community
  	When I archive the poll
  	Then I can edit the poll and it remain archived
