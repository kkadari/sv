@JUC21
Feature: JUC21 - Read a discussion

  @sit
  Scenario: Participant can read a Discussion
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
