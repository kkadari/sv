@JUC21
Feature: JUC21 - Read a discussion

  @JUC21.2 @CISP-417
  Scenario: Participant views an amber anonymous discussion
  	Given I have logged in as "participant A"
    And I have quickly created an amber discussion anonymously in a private group
    When I have logged in as "participant B"
    Then I can view the anonymous discussion
    
  @JUC21.4 @CISP-546
  Scenario: Admin views an amber anonymous discussion
    Given I have logged in as "participant A" 
    And I have quickly created an amber discussion anonymously in a private group
    When I have logged in as "admin"
    Then as an admin I can view the anonymous discussion