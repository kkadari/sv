Feature: TBC - Navigate away from content via breadcrumb links

  @CISP-183
  Scenario: Participant uses breadcrumb link to view more polls in a related container
    Given I have navigated away from a poll using the breadcrumb links
    Then I am able to view more polls in a related container

  Scenario: Participant navigates away from an incident report using breadcrumb links
    Given I log in
      | CE participant email and password |
    And I view an incident report
      | Any incident report |
    Then I am viewing an incident report
    And I click the 'More incident reports' link in the breadcrumb trail
    And I am viewing the Content page for the related container, filtered by the content type

  Scenario: Participant navigates away from a discussion using breadcrumb links
    Given I log in
      | CE participant email and password |
    And I view a discussion
      | Any discussion that has not been published anonymously. |
    Then I am viewing a discussion
    And I click the 'More discussions' link in the breadcrumb trail
    And I am viewing the Content page for the related container, filtered by the content type
    And I view an anonymous discussion
      | Any discussion that has been published anonymously to the communit space. |
    Then I am viewing a discussion, and there is no breadcrumb trail displayed
