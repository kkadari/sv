Feature: [CISP-155] Participant wants to directly message two or more Participants with an Internal Reference
#<p>Test written to cover: JUC24.1: Participant wants to directly message two or more Participants with an Internal Reference</p>

Scenario: Participant wants to directly message two or more Participants with an Internal Reference
	Given Given I log in 
		|  CE participant email and password  |
	When I create a direct message
		|  To: {two or more CE participants} |
	And I reference internal content, e.g. a person or group within the system.
		"""  Message:
			Hi {internal mention},

			Check out this discussion: {internal discussion link}
			Check out this question: {internal discussion question link}
			Check out this IR: {internal incident report link}
			Check out this Poll: {internal poll link}
			Check out this blog post: {internal blog post link}

			Check out this group: {internal group link}
			Check out this space: {internal space link}

			Thanks,
			{internal link to this CE participant}  """
	Then the system renders this reference such that it is clickable. For people and places (spaces/groups etc), when hovering over the links, a hovercard is displayed.
	And I submit the message
	Then the system sends the message to the Inbox of all Participants selected to receive the message
	And the e-mail notification received does not contain content from the body of the Direct Message
	Then the e-mail notification received does not contain content from the body of the Direct Message
