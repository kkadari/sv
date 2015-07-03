@JUC21
Feature: JUC21 - Read a discussion
#<p>This test has been written to cover the following use case realisation(s): </p>
#<p>JUC21.6: Page not available</p>

  @sit
  Scenario: Participant can read a discussion
    Given I have logged in as "participant A"
    When I find and click on a discussion I would like to read
    Then I can view the discussion

  @JUC21.2 @CISP-417
  Scenario: Participant views an amber anonymous discussion
  	Given I have logged in as "participant A"
    And I have quickly created an amber discussion anonymously in a private group
    When I have logged in as "participant B"
    Then I can locate and view the anonymous discussion
    
  @JUC21.4 @CISP-546
  Scenario: Admin views an amber anonymous discussion
    Given I have logged in as "participant A" 
    And I have quickly created an amber discussion anonymously in a private group
    When I have logged in as "admin"
    Then as an admin I can view the anonymous discussion

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
