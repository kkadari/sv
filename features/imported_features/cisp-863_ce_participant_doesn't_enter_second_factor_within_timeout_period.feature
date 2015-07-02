Feature: [CISP-863] CE Participant doesn't enter second factor within timeout period
#<p>This test was written to covers UC realisation(s):</p>
#<p>JUC40.4: CE Participant doesn't enter second factor within timeout period.</p>

  Scenario: CE Participant doesn't enter second factor within timeout period
	Given I navigate to the CE
	Then I am presented with a login form, inviting me to enter my email address and password
	And I enter my email address and password correctly
	Then the system confirms my user credentials, sends a second factor (a numeric key) to my mobile handset and displays another login form to enter the second factor
	And I pause for more than 300 seconds (second factor timeout period)
	Then the system informs me that my session has expired and that I will be re-directed to the initial login page
	And I log out of the CE
	And I navigate to the CE again
	Then I am presented with a login form inviting me to enter my email address and password
