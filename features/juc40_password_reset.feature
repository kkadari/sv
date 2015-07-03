Feature: Password reset
#<p>Purpose of this test is to cover:</p>
#<ul class="alternate" type="square">
#<p>JUC40.1: CE Participant successfully authenticates/accesses the CE.</p>
#<p>JUC40.4: CE Participant doesn't enter second factor within timeout period.</p>
#	<li>JUC40.5: CE Participant resets password successfully</li>
#   <li>JUC40.6: Valid CE user resets password successfully</li>
#	<li>JUC40.7 - As a CE Participant I want to be able to reset my password if I have forgotten so that I don't need to go through support, slowing me down</li>
#</ul>

  Scenario: CE Participant cannot use a Password Reset token post-timeout
    Given Visit the CE login page
    Then CE login form is displayed, containing a 'Forgotten Password' option.
    And Select Forgotten Password option
    Then The system presents a form asking the CE Participant to enter their email address.
    And Enter a valid CE participant e-mail address and submit form.
    Then Form submitted successfully. The system informs the CE Participant that a password reset link has been sent to the entered email address.
    And Check the e-mail inbox of the CE Participant
    Then The system has sent an email to the CE Participant's email address with a link allowing them to reset the password.
    And Wait until the password reset token timeout limit has been reached
      |  [TO BE CONFIRMED]  |
    Then Then the password reset token timeout has been reached.
    And Click the link within the e-mail to reset the password.
    Then The CE Participant is presented with the password reset form.

  Scenario: Valid CE Participant resets password via Forgotten Password link successfully
    Given Visit the CE login page
    Then CE login form is displayed, containing a 'Forgotten Password' option
    And Select Forgotten Password option
    Then The system presents a form asking the CE Participant to enter their email address
    And Enter a valid CE participant e-mail address and submit form
    Then Form submitted successfully. The system informs the CE Participant that a password reset link has been sent to the entered email address
    And Check the e-mail inbox of the CE Participant
    Then The system has sent an email to the CE Participant's email address with a link allowing them to reset the password
    And Click the link within the e-mail to reset the password
    Then The CE Participant is presented with the password reset form, and instructed to select a new password
    And Enter a suitable password twice in the password reset form and submit form
    Then The system confirms the users credentials and the {system sends the second factor} (a numeric key) to the users mobile handset
    And Enter the second factor into the second factor form and submit form
    Then The system confirm the second factor, and presents the CE Participant's home page to the CE Participant

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

  Scenario: CE Participant successfully authenticates/accesses the CE
    Given I navigate to the CE.
    Then I am presented with a login form, inviting me to enter my email address and password.
    And I successfully enter my email address and password.
    Then the system confirms my user credentials, sends a second factor (a numeric key) to my mobile handset and displays another login form to enter the second factor.
    And I successfully enter the second factor (numeric key).
    Then the system confirms the second factor, and displays my CE home page.
    And I log out of the CE.
    And I navigate to the CE again.
    Then I am presented with a login form inviting me to enter my email address and password.

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

