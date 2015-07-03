Feature: Password reset
#<p>Purpose of this test is to cover:</p>
#<ul class="alternate" type="square">
#	<li>JUC40.7 - As a CE Participant I want to be able to reset my password if I have forgotten so that I don't need to go through support, slowing me down</li>
#   <li>JUC40.6: Valid CE user resets password successfully</li>
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
