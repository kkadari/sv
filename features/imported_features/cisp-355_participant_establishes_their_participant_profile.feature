Feature: [CISP-355] Participant establishes their Participant Profile
#<p>This test covers use case realisation JUC1.1 - Participant establishes their Participant Profile.</p>

  Scenario: Participant establishes their Participant Profile
	Given I log in
	  | CE participant email and password (as User A) |
	And I navigate to People
	Then I am viewing the People list
	And I filter on a specific CE participant
	  | (User B) |
	Then I have filtered the list of CE participants to the user I am interested in
	And I select to view a specific CE participant within the People list
	  | (User B) |
	Then I am displayed the Bio tab within the profile of the CE participant
	And I log in
	  | CE participant email and password (as User B) |
	And I navigate to 'Edit my profile and privacy' from the Jive menu
	Then I am presented with a form to edit my profile details
	And I make a change to my profile details
	  | Variants: But profile fields should be altered from their current state (in line with privacy settings) |
	Then I have updated my profile
	And I save changes to my profile fields
	Then my profile is updated and stored in the system
	And I navigate to the 'Privacy Settings' tab
	Then I am viewing the privacy settings for my profile
	And I set profile fields that I have updated to be visible to 'Friends'
	  | (Depends on variants of step 9) |
	Then I have updated my privacy settings
	And I save changes to my privacy settings
	Then my privacy settings are updated and stored in the system
	And if I log in
	  | CE participant email and password (as User A) |
	And I navigate to the profile of the CE participant that recently update their profile
	  | (User B) |
	Then I am viewing the CE participant profile
	And I am presented with an updated version of the CE participant profile
	Then I am viewing an updated version of the CE participants profile.
