Feature: [CISP-862] CE Participant successfully authenticates/accesses the CE after a single failed attempt
#<p>This test was written to covers UC realisation(s):</p>
#<p>JUC40.1: CE Participant successfully authenticates/accesses the CE.</p>

  Scenario: CE Participant successfully authenticates/accesses the CE after a single failed attempt
	Given I navigate to the CE
	Then I am presented with a login form, inviting me to enter my email address and password
	And I enter my email address and password incorrectly
	  | [Enter valid e-mail address, but incorrect password.] |
	Then the system rejects my user credentials, and redirects the user to the same form again, inviting me to enter my email address and password again
	And I enter my email address and password correctly
	Then the system confirms my user credentials, sends a second factor (a numeric key) to my mobile handset and displays another login form to enter the second factor
	And I successfully enter the second factor (numeric key)
	Then the system confirms the second factor, and displays my CE home page
	And I log out of the CE
	And I navigate to the CE again
	Then I am presented with a login form inviting me to enter my email address and password
