Feature: [CISP-154] Participant wants to directly message another Participant with an Internal Reference
#<p>Test written to cover BF &amp; AF1 for JUC24: Send a Private Message, but to a single Participant.</p>

  Scenario: Participant wants to directly message another Participant with an Internal Reference
    Given I log in
      |  CE participant email and password  |
	And I create a direct message
		|  To: {one or more CE participants} |
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
	Then the system renders this reference such that it is clickable and gives a hover-over summary of the content.
	And I submit the message
	Then the system sends the message to the Inbox of all Participants selected to receive the message
