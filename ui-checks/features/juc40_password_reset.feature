@manual
Feature: Password reset
#JUC40.1: CE Participant successfully authenticates/accesses the CE
#JUC40.4: CE Participant doesn't enter second factor within timeout period
#JUC40.5: CE Participant resets password successfully
#JUC40.6: Valid CE user resets password successfully
#JUC40.7: As a CE Participant I want to be able to reset my password if I have forgotten so that I don't need to go through support, slowing me down

  Scenario: CE Participant cannot use a Password Reset token post-timeout
    Given I have submitted the forgotten password form
    And I have received an email with a link to reset my password
    When I leave the reset token to timeout
    Then using the reset link will redirect me back to the forgotten password form

  Scenario: Valid CE Participant resets password via Forgotten Password link successfully
    Given I have submitted the forgotten password form
    And I have received an email with a link to reset my password
    When I click on the link to reset my password
    And submit a new password in the password reset form
    Then I am taken to the second factor login page
    And completing the second factor login will log me into the application

  Scenario: CE Participant attempts to reset password but fails password quality check
    Given I have submitted the forgotten password form
    And I have received an email with a link to reset my password
    When I click on the link to reset my password
    And submit a new password in the password reset form that is very weak
    Then I will receive a validation error informing my password does not match the quality checks

  Scenario: CE Participant successfully authenticates/accesses the CE
    Given I am on the login form
    When I submit the login form with valid credentials
    Then I am taken to the second factor login page
    And completing the second factor login will log me into the application

  Scenario: CE Participant successfully authenticates/accesses the CE after a single failed attempt
    Given I have attempted to log into CE with bad credentials
    When I submit the login form with valid credentials
    Then I am taken to the second factor login page
    And completing the second factor login will log me into the application

  Scenario: CE Participant doesn't enter second factor within timeout period
    Given I have managed to reach the second factor stage of the login process
    When I leave the second stage code to timeout
    And then submit the second stage code
    Then I am redirected back to the initial login page
