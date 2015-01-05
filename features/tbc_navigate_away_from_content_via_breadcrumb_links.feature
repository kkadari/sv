Feature: TBC - Navigate away from content via breadcrumb links

  @CISP-183
  Scenario: Participant uses breadcrumb link to view more polls in a related container
    Given I have navigated away from a poll using the breadcrumb links
    Then I am able to view more polls in a related container