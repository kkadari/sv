Feature: [CISP-159] Participant wants to respond to a Private Message with an Internal Reference
#<p>Test written to cover JUC25.3 - Participant responds to a Private Message with an Internal Reference</p>

  Scenario: Participant wants to respond to a Private Message with an Internal Reference
	Given I log in
	|  CE participant email and password  |
	When I navigate to my inbox
	Then I am viewing my inbox
	And I have been sent a message
	Then my inbox contains an unread message
	And if I select an unread message
	Then it is marked as read and the full message is displayed
	And I create a new response that references internal content (e.g. a person or group within the system)
	  """  Message:
	  Thanks {internal link to the sender}, try these:

	  An internal link to a discussion: {internal discussion link}
	  An internal link to a question: {internal discussion question link}
	  An internal link to an answered question: {internal answered question link}
	  An internal link to an IR: {internal incident report link}
	  An internal link to a Poll: {internal poll link}
	  An internal link to a blog post: {internal blog post link}

	  Also, check out this group: {internal group link}
	  Or this space: {internal space link}

	  Thanks,
	  {internal link to the current CE participant}  """
	And I submit the response
	Then the system sends the message to the Inbox of the original sender.
