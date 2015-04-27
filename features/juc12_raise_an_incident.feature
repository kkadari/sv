@JUC12
Feature: JUC12 - Raise an incident
 
  @JUC12.1 @CISP-591
  Scenario: Participant views mention in inbox
    Given I have logged in as "participant A"
    And I have mentioned "participant B" in a red incident report in a private group
    When I have logged in as "participant B"
    Then my inbox shows I have been mentioned

  @JUC12.2 @CISP-593
  Scenario: Participant view anonymous mention in inbox
    Given I have logged in as "participant A"
    And I have mentioned "participant B" in a red incident report anonymously in a private group
	When I have logged in as "participant B"
	Then my inbox shows I have been mentioned anonymously
 
  @CISP-163
  Scenario: A participant raises a red incident report in a private group
	Given I have logged in as "participant A"
	And I have quickly raised a red incident report in a private group
	Then I am able to view the marking
		
  @CISP-164
  Scenario: A participant raises an amber incident report in a private group
	Given I have logged in as "participant A"
	And I have quickly raised an amber incident report in a private group
	Then I am able to view the marking
		
  @CISP-165
  Scenario: A participant raises a green incident report in a private group
	Given I have logged in as "participant A"
	And I have quickly raised a green incident report in a private group
	Then I am able to view the marking
		
  @CISP-166
  Scenario: A participant raises a white incident report in a private group
	Given I have logged in as "participant A"
	And I have quickly raised a white incident report in a private group
	Then I am able to view the marking
	
  @CISP-196
  Scenario: Participant raises an amber incident report anonymously in a private group
    Given I have logged in as "participant A" 
    When I have quickly raised an amber incident report anonymously in a private group
    Then I can verify the anonymous identifiers have been added
    
  @CISP-261
  Scenario: Participant can link to content in an IR
    Given I have logged in as "participant A"
    And I have quickly raised a white incident report anonymously in a private group
    And I have raised a white incident report in a private group containing an internal link
	When I have logged in as "participant B"
	Then I can view the internal link