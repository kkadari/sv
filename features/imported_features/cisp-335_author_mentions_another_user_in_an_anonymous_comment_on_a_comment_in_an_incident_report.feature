Feature: [CISP-335] Author mentions another user in an anonymous comment on a comment in an Incident Report
#<p>This test was written to cover the following use case realisation(s):</p>
#<ul class="alternate" type="square">
#	<li>JUC4.3: Author of the comment mentions another Participant in an anonymous comment on a comment</li>
#</ul>
#<p>This test requires two CE participant user accounts (referred to as User A, User B).</p>

  Scenario: Author mentions another user in an anonymous comment on a comment in an Incident Report
	Given I log in
	  | CE participant email and password (User A) |
	And I navigate to the relevant location to view an incident report that has a comment on it
	  | Any incident report that the participant(s) have the appropriate permissions to view, that also has a comment contained within it. |
	Then the system displays the incident report.
	And I select to comment on an existing comment on an incident report, mentioning another CE participant
	  | Comment: THIS IS A TEST ANON COMMENT REPLY - @[User B] - PLEASE DISREGARD |
	And I indicate that the comment should be submitted anonymously
	Then I have mentioned another user and marked the comment to be anonymous.
	And I submit the comment
	Then the comment is submitted anonymously.
	And I view the incident report
	Then I (as the author) am shown my details when viewing the comment and the comment shows that it was posted anonymously.
	And I log in
	  | CE participant email and password (User B) |
	And I navigate to my inbox
	Then I am viewing my inbox
	And I have received a notification that I was mentioned in an incident report.
	Then my inbox contains an unread message but the Author of the anonymous comment is not visible (and is attributed to Anonymous).
	And I select an unread message
	Then it is marked as read and the full message is displayed, but the Author of the anonymous comment is not visible (and is attributed to Anonymous).
