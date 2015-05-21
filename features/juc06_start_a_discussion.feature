@JUC6
Feature: JUC6 - Start a discussion

  @JUC6.1 @CISP-412 @JUC21.1 @CISP-416
  Scenario: Participant creates a community wide discussion
    Given I have logged in as "participant A"
    And I have quickly created an amber discussion in the community
    When I have logged in as "participant B"
    Then I can locate and view the discussion

  @JUC6.2 @CISP-413
  Scenario: Participant creates a discussion with non standard IHM
  	Given I have logged in as "participant A"
    And I have quickly created a red discussion in a private group
    When I have logged in as "participant B"
    Then I can locate and view the discussion
	
  @JUC6.3 @CISP-414
  Scenario: Participant creates a discussion in a private group
  	Given I have logged in as "participant A"
    And I have quickly created an amber discussion in a private group
    When I have logged in as "participant B"
    Then I can locate and view the discussion
	
  @JUC6.4 @CISP-415 @JUC21.2 @CISP-864
  Scenario: Participant raises an amber anonymous discussion
  	Given I have logged in as "participant A"
    And I have quickly created an amber discussion anonymously in a private group
    When I have logged in as "participant B"
    Then I can locate and view the anonymous discussion
    
  @JUC6.4 @CISP-807
  Scenario: Participant raises an anonymous question in a group
    Given I have logged in as "participant A"
    And I have quickly created an amber discussion question anonymously in a private group
    When I have logged in as "participant B"
    Then I can verify the anonymous identifiers have been added to the discussion
	
  @JUC6.4 @CISP-808
  Scenario: Participant raises an anonymous question in a space
    Given I have logged in as "participant A" 
    And I have quickly created an amber discussion question anonymously in a space
    When I have logged in as "participant B"
    Then I can verify the anonymous identifiers have been added to the discussion