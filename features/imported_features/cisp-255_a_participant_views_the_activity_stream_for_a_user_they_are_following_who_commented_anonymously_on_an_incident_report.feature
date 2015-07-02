Feature: [CISP-255] A Participant views the Activity Stream for a user they are following who commented anonymously on an Incident Report
#<p>The focus of this test is to cover the following use case flow:</p>
#
#<ul class="alternate" type="square">
#	<li>JUC27: Raise an Incident - AF1: Participant is following a user who posts content Anonymously</li>
#</ul>
#<p>Please note: This test requires two users' interaction with the CE (User A, User B), where User B is following User A.</p>

  Scenario: A Participant views the Activity Stream for a user they are following who commented anonymously on an Incident Report
	Given I log in
	  | User A: CE participant email and password |
	And I navigate to the relevant location to view an incident report
	  | Any incident report that the participants has the appropriate permissions to view. |
	Then the system displays the incident report.
	And I select to comment
	  | THIS IS A TEST COMMENT - PLEASE DISREGARD |
	And I indicate that the comment should be submitted anonymously
	Then I have marked the comment to be anonymous.
	And I submit the comment
	Then the comment is submitted anonymously.
	And I view the incident report
	Then I (as the author) am shown my details when viewing the comment and the comment shows that it was posted anonymously.
	And I log out (as User A)
	And I log in
	  | User B: CE participant email and password |
	And I navigate to an Activity Stream for a CE participant who has recently posted a comment on incident report anonymously.
	  | People -> (User A) -> Activity |
	Then I am viewing the Activity Stream for the CE participant
	And I am presented with the latest content from the stream
	Then the posting of the anonymous comment is not shown in the stream.
