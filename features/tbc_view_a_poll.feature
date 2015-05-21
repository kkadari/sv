Feature: TBC View a poll

  @sit
  Scenario: Participant can read a Poll
    Given I have logged in as "participant A"
    When I find and click on a poll I would like to read
    Then I can view the poll