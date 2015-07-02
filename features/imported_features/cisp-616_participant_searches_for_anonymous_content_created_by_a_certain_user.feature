Feature: [CISP-616] Participant searches for Anonymous content created by a certain user
#<p>This test has been written to cover the following use case realisation(s): </p>
#
#<p>JUC26.4: Participant searches for content created by a certain user</p>

  Scenario: Participant searches for Anonymous content created by a certain user
	Given I log in
	  | CE participant email and password (User A) |
	And I navigate to the relevant location to create an incident report
	Then I presented with a page for creating a new IR. The page is pre-populated with a default IHM level: Amber
	When I populate all the new incident report form fields, and mention a specific user in the incident report body
	  | THIS IS A TEST INCIDENT REPORT - PLEASE DISREGARD | THIS IS A TEST INCIDENT REPORT BODY FOR @[UserA] - PLEASE DISREGARD | Red | In a specific place: Testing (Group) |
	Then I have populated the incident report form fields
	And I indicate that the incident report should be submitted anonymously
	Then I have marked the incident report to be posted anonymously
	And I submit the incident report form
	Then the incident report form is submitted and the system will persist the new IR with a unique identifier. The system directs me to the incident report, which shows attribution to my user, but shows that it was posted anonymously
	And I log in (as User B)
	  | CE participant email and password (for User B) |
	And I enter search term(s) for an incident report into the Jive search box, restricting the search results by user
	  | [Enter search terms for the incident report created by User A, and restrict by User A] |
	Then Jive Search will (attempt to) find content matching the search term(s), but content posted Anonymously by the user (User A) is omitted from search results
	Then I am logged out (as User B)
