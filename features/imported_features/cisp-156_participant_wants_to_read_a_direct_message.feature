Feature: [CISP-156] Participant wants to read a direct message
#<p>Test written to cover JUC25.1: Participant reads a direct message</p>

  Scenario: Participant wants to read a direct message
	Given I log in
      | CE participant email and password |
    When I navigate to my inbox
    Then I am viewing my inbox
    And I have been sent a message
    Then my inbox contains an unread message
    And if I select an unread message
    Then it is marked as read and the full message is displayed
