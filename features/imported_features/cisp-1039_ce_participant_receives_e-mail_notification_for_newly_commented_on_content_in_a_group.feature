Feature: [CISP-1039] CE Participant receives e-mail notification for newly commented on content in a Group

  Scenario: CE Participant receives e-mail notification for newly commented on content in a Group
	Given I log in
	  | CE participant email and password |
	And another CE participant is following a group I am a member of
	  | Email notifications have been enabled for the stream the user is following the group in. |
	And I select the option to comment, review, or reply to existing content within the CE
	  | Variants										 |
	  | ALL CONTENT TYPES that support comments/replies. |
	  | CHECK ANONYMOUS submissions too.                 |
	Then I am displayed the appropriate form for commenting, reviewing or reply to the content type within the CE
	And I populate and submit the comment/review/reply form
	  | [Populate with recognisable data] |
	Then the system acknowledges and displays the newly submitted comment/review/reply
	And the CE participant following the group receives an e-mail notification that a comment/reply/review was made on the relevant content type.
	Then the e-mail notification From address does not show the author of the comment/review/reply, nor does the e-mail notification contain any information relating to the content author (including the URL to the content)
