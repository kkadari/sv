Feature: [CISP-254] A Participant views the Activity Stream for a user they are following who posted an Incident Report anonymously
#<p>The focus of this test is to cover the following use case flow:</p>
#
#<ul class="alternate" type="square">
#	<li>JUC27: Raise an Incident - AF1: Participant is following a user who posts content Anonymously</li>
#</ul>
#<p>Please note: This test requires two users' interaction with the CE (User A, User B), where User B is following User A.</p>

  Scenario: A Participant views the Activity Stream for a user they are following who posted an Incident Report anonymously
	Given I log in
	  | User A: CE participant email and password |
	And I navigate to the relevant location to create an incident report
	Then I presented with a page for creating a new IR. The page is pre-populated with a default IHM level: Amber
	And I populate all the new incident report form fields, and change the IHM level
	| THIS IS A TEST INCIDENT REPORT - PLEASE DISREGARD | THIS IS A TEST INCIDENT REPORT BODY - PLEASE DISREGARD | Red | In a specific place: Testing (Group) |
	Then I have populated the incident report form fields
	And I select to post the incident report anonymously
	Then I have marked the incident report to be posted anonymously
	And I submit the incident report form
	Then the incident report form is submitted and the system will persist the new IR with a unique identifier, and with attribution to the Participant who created the IR
	And I log out (as User A)
	And I log in
	  | User B: CE participant email and password |
	And I navigate to an Activity Stream for a CE participant who has recently posted an incident report anonymously.
	  | People -> (User A) -> Activity |
	Then I am viewing the Activity Stream for the CE participant
	And I am presented with the latest content from the stream
	Then the posting of the anonymous content is not shown in the stream.
