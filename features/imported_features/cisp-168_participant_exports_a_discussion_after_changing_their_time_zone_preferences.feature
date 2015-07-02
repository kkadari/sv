Feature: [CISP-168] Participant exports a discussion after changing their Time Zone preferences

  Scenario: Participant exports a discussion after changing their Time Zone preferences
    Given I log in
      | CE participant email and password |
    And I navigate to my user Preferences screen
    Then I am viewing my Preferences
    And I alter my Time Zone
      | Change it from GMT to something more exotic (+/- 4 hours) |
    And submit changes to my preferences
    Then my preferences are saved
    And view a discussion
      | Any discussion that the CE participant has access to. |
    Then the discussion is displayed
    And export a discussion to PDF
    Then the discussion is exported to PDF and the timestamp displayed in the body content (discussion threads) and footer is adjusted for my Time Zone preferences
