Feature: TBC View an uploaded document

  @sit
  Scenario: Participant can read an Uploaded file
    Given I have logged in as "participant A"
    When I find and click on an uploaded document I would like to read
    Then I can view the uploaded document