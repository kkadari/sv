Feature: [CISP-618] Participant searches for comments content created by a certain user
#<p>This test has been written to cover the following use case realisation(s): </p>
#<p>JUC26.5: Participant searches for comments content created by a certain user</p>

  Scenario: Participant searches for comments content created by a certain user
	Given I log in
	  | CE participant email and password (User A) |
	And I navigate to an Incident Report within the system that I wish to view in more detail.
	Then the system checks that the Incident Report exists and is valid, and displays the Incident Report.
	And I select to comment
	  | THIS IS A TEST COMMENT - PLEASE DISREGARD |
	And I indicate that the comment should be submitted anonymously
	Then I have marked the comment to be anonymous.
	And I submit the comment
	Then the comment is submitted anonymously.
	And I view the incident report
	Then I (as the author) am shown my details when viewing the comment and the comment shows that it was posted anonymously.
	And I log out (as User A)
	And I log in (as User B)
	  | CE participant email and password (for User B) |
	And I enter search term(s) for a comment into the Jive search box, restricting the search results by user
	  | [Enter search terms for the comment created by User A, and restrict by User A] |
	Then Jive Search will (attempt to) find content matching the search term(s), but Anonymous comments posted are not attributed to the user (User A), and as such are omitted from search results.
