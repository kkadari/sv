Feature: [CISP-853] CE Participant attempts to reset password but fails password quality check
#<p>This test was written to covers UC realisation(s):</p>
#<p>JUC40.6: As a CE Participant I want to be informed if my password reset is unsuccessful so that I don't think my password reset has worked.</p>

  Scenario: CE Participant attempts to reset password but fails password quality check
	Given that my CE user account requires a password reset on next login
	  | [Configure [User A's] AD account to force password reset on next login] |
	Then my user account is configured to require a password reset on next login
	And I navigate to the CE (without an existing session)
	Then I am presented with a login form inviting me to enter my email address and password
	And I enter a valid e-mail account and password and submit my details
	  | [for User A - a normal user] |
	Then the system confirms my user credentials, and presents me with a password reset form, along with instructions on how to select a new password (and the current password policy)
	And I enter password combinations into the password reset form that do not pass the password quality check
	  """ [All of the combinations outlined in the comment below these steps should fail.
	  Please note: requirement around maximum password reset attempts within a single session (excludes mismatch JS popups).]  """
	Then the system instructs the CE Participant that their password reset failed, and presents the password reset form again, along with instructions on how to select a new password (and the current password policy)
	And I close my session (exit the CE / login screen)
	Then my CE session ends
	And I navigate to the CE again (e.g. a new browser session, such that I don't have an existing session)
	Then I am presented with a login form inviting me to enter my email address and password
	And if I enter a valid e-mail account and password and submit my details
	  | [for User A - a normal user] |
	Then my existing password is accepted by the system (and has not been altered during previous test steps), the system confirms my user credentials, and presents me with a password reset form, along with instructions on how to select a new password (and the current password policy)
