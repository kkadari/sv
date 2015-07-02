Feature: [CISP-258] A Participant views the Activity Stream for a user they are following who recently edited an anonymous Incident Report
#<p>The focus of this test is to cover the following use case flow:</p>
#
#<ul class="alternate" type="square">
#	<li>JUC27: Raise an Incident - AF1: Participant is following a user who posts content Anonymously</li>
#</ul>
#<p>Please note: This test requires two users' interaction with the CE (User A, User B), where User B is following User A.</p>

  Scenario: A Participant views the Activity Stream for a user they are following who recently edited an anonymous Incident Report
	Given I log in
	  | User A: CE participant email and password |
	And I navigate to the relevant location to view an incident report
	  | An incident report previously published by the CE participant. |
	Then the system displays the incident report.
	And I select to Edit the Incident Report posted Anonymously
	Then I am shown the details of the Incident Report which are editable, except for the ability to select whether the Incident Report is posted anonymously (this cannot be altered).
	And I edit the incident report
	  | Appending 'UPDATE' to the Incident Report body field. |
	Then I have edited the anonymous incident report.
	And I submit the edited incident report form
	Then the incident report form is submitted and the system will persist the IR.
	And I log in
	  | User B: CE participant email and password |
	And When I navigate to an Activity Stream for a CE participant who has recently edited an anonymous incident report.
	  | People -> (User A) -> Activity |
	Then I am viewing the Activity Stream for the CE participant
	And I am presented with the latest content from the stream
	Then the posting of the anonymous content is not shown in the stream.
