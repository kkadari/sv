Feature: [CISP-157] Participant wants to respond to a Private Message
#<p>Test written to cover JUC25.2 - Participant responds to a Private Message</p>

  Scenario: Participant wants to respond to a Private Message
	Given I log in
	  |  CE participant email and password  |
	When I navigate to my inbox
	Then I am viewing my inbox
	And I have been sent a message
	Then my inbox contains an unread message
	And if I select an unread message
	Then it is marked as read and the full message is displayed
	And I create a response
	  |  Message: "Thanks!"  |
	And I submit the response
	Then the system sends the message to the Inbox of the original sender.
