Feature: [CISP-547] Participant views a Discussion directly
#<p>This test covers JUC21.5 - Participant views a Discussion directly</p>

  Scenario: Participant views a Discussion directly
	Given I log in
	  | CE participant e-mail and password. |
	Then I am logged in to the CE
	And I have identified an existing Discussion I wish to view within the system
	  | {pre-existing content that the user has not authored} |
	Then I have identified an existing Discussion that exists within the CE
	And I enter the URL for the Discussion directly into the browser
	Then I have entered the URL for the Discussion into my browser and navigate to the URL
	Then the system checks that the Discussion exists and is valid
	Then the system displays the discussion and records appropriate metrics to capture the viewing of the discussion
