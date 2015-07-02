Feature: [CISP-619] Participant attempts to view a Discussion that is not available
#<p>This test has been written to cover the following use case realisation(s): </p>
#<p>JUC21.6: Page not available</p>
#
#<p>There may be many ways to achieve this, but this test covers the deletion of a discussion, and subsequent attempts to access that discussion URL by another user post-deletion.</p>

  Scenario: Participant attempts to view a Discussion that is not available
	Given I log in (as User A)
	  | CE participant email and password (for User A) |
	And I identify a Discussion within the system that I wish to view in more detail
	  | [A discussion that the user has access to - take note of the Discussion URL] |
	Then the system checks that the Discussion exists and is valid and displays the Discussion
	And I log in
	  | Admin email and password (User A) |
	And I navigate to a Discussion within the system that I wish to view in more detail
	  | [The same Discussion identified by User A in previous steps] |
	Then the system checks that the Discussion exists and is valid and displays the Discussion
	And I select the option to Delete the discussion
	Then I am asked to confirm whether I wish to delete the discussion
	And I confirm that I wish to Delete the discussion
	Then the system deletes the discussion, and displays the parent container of the deleted discussion
	And I log in (as User A)
	  | CE participant email and password (for User A) |
	And I attempt to navigate to a Discussion within the system that previously existed that I wish to view in more detail
	  | [The same Discussion identified by User A in previous steps] |
	Then the system displays a 'Not Found' error message
