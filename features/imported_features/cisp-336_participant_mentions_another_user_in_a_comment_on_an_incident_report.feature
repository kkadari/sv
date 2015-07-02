Feature: [CISP-336] Participant mentions another user in a comment on an Incident Report
#<p>This test was written to cover the following use case realisation(s):</p>
#<ul class="alternate" type="square">
#	<li>JUC4.1: Author of the comment mentions another Participant</li>
#</ul>
#<p>This test requires two CE participant user accounts (referred to as User A, User B).</p>

  Scenario: Participant mentions another user in a comment on an Incident Report
	Given I log in
	  | CE participant email and password (User A) |
	And I navigate to the relevant location to view an incident report
	  | Any incident report that the participants has the appropriate permissions to view. |
	Then the system displays the incident report.
	And I select to comment on an incident report, mentioning another CE participant
	  |	THIS IS A TEST COMMENT - @[User B] - PLEASE DISREGARD |
	Then I have mentioned another user
	And I submit the comment
	Then the comment is submitted.
	Then I view the incident report
	Then I (as the author) am shown my details when viewing the comment
	And I log in
	  | CE participant email and password (User B) |
	And I navigate to my inbox
	Then I am viewing my inbox
	And I have received a notification that I was mentioned in an incident report.
	Then my inbox contains an unread message and the Author of the comment is visible (attributed to User A).
	And I select an unread message
	Then it is marked as read and the full message is displayed, and the Author of the comment is visible (and is attributed to User A).
