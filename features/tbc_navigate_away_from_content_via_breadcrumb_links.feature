Feature: TBC - Navigate away from content via breadcrumb links

  @CISP-183
  Scenario: Participant uses breadcrumb link to view more polls in a related container
    Given I have navigated away from a poll using the breadcrumb links
    Then I am able to view more polls in a related container

  @manual
  Scenario: Participant navigates away from an incident report using breadcrumb links
    Given I am viewing an incident report
    When I click on the 'More incident reports' link in the breadcrumb trail
    Then I am taken to the content page filtered by incident report

  @manual
  Scenario: Participant navigates away from a discussion using breadcrumb links
    Given I am viewing a discussion
    When I click on the 'More discussions' link in the breadcrumb trail
    Then I am taken to the content page filtered by discussion
