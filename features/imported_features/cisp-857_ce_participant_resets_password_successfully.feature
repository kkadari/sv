Feature: [CISP-857] CE Participant resets password successfully
#<p>This test was written to cover UC realisation(s):</p>
#<ul class="alternate" type="square">
#	<li>JUC40.5: CE Participant resets password successfully</li>
#</ul>

  Scenario: CE Participant resets password successfully
	Given that my CE user account requires a password reset on next login.
	  | [Configure [User A's] AD account to force password reset on next login] |
	Then my user account is configured to require a password reset on next login
	And I navigate to the CE (without an existing session)
	Then I am presented with a login form inviting me to enter my email address and password
	And I enter a valid e-mail account and password and submit my details
	  | [for User A - a normal user] |
	Then the system confirms my user credentials, and presents me with a password reset form, along with instructions on how to select a new password (and the current password policy)
	And I enter password combinations into the password reset form that meet the password quality check standard and submit the form
	  | Contains at least 8 characters									  |
	  | Contains characters from at least 3 of the following 5 categories |
	  | English uppercase characters (A - Z)                              |
	  | English lowercase characters (a - z)                              |
	  | Base 10 digits (0 - 9)                                            |
	  | Non-alphanumeric (For example: !, $, #, or %)                     |
	  | Unicode characters                                                |
	And does not contain three or more characters from the username
	Then the password reset form is submitted successfully, the system confirms the users credentials and the system sends the second factor (a numeric key) to the users mobile handset.
	And I close my session (exit the CE / login screen)
	Then my CE session ends
	And I navigate to the CE again (e.g. a new browser session, such that I don't have an existing session)
	Then I am presented with a login form inviting me to enter my email address and password.
	And if I enter a valid e-mail account and new password and submit my details
	  | [for User A - a normal user] |
	Then my new password is accepted by the system, the system confirms my user credentials, sends the second factor (a numeric key) to the users mobile handset, and displays a form to enter the second factor
	And I successfully enter the numeric key sent to my mobile handset
	Then I am presented with the CE home page
