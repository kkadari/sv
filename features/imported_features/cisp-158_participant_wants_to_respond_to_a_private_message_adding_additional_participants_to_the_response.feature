Feature: [CISP-158] Participant wants to respond to a Private Message adding additional Participants to the response
#<p>Test written to cover JUC25.4 - Participant responds to a Private Message adding additional Participants to the response</p>

  Scenario: Participant wants to respond to a Private Message adding additional Participants to the response
	Given I log in
	  | CE participant email and password |
	When I navigate to my inbox
	Then I am viewing my inbox
	And I have been sent a message
	Then my inbox contains an unread message
	And if I select an unread message
	Then it is marked as read and the full message is displayed
	And I add additional Participants to the distribution list.
	  | Add one or more CE participants. |
	And I create a new response
	  |  Message: "Thanks!"  |
	And I submit the response
	Then the system sends the original message and all responses to the full distribution list (including the newly added recipient(s)).

