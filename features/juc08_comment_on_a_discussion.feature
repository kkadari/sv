@JUC8
Feature: JUC8 - Comment on a discussion

  @JUC8.1 @CISP-142
  Scenario: Participant comments on a discussion
    Given I have logged in as "participant A"
    And I have quickly created an amber discussion in a private group
    When I have logged in as "participant B"
    Then I can comment on the discussion

  @JUC8.2 @CISP-482
  Scenario: Participant comments on a comment on a discussion
    Given I have logged in as "participant A"
    And I have quickly created an amber discussion in a private group
	And I have commented on the discussion
	When I have logged in as "participant B"
    Then I can comment on the comment

  @JUC8.3 @CISP-508
  Scenario: Participant comments anonymously on a discussion
    Given I have logged in as "participant A"
    And I have quickly created an amber discussion in a private group
    When I have logged in as "participant B"
    Then I can comment on the discussion anonymously
	
  @JUC8.4 @CISP-509
  Scenario: Participant comments anonymously on a comment on a discussion
  	Given I have logged in as "participant A"
    And I have quickly created an amber discussion in a private group
	And I have commented on the discussion
	When I have logged in as "participant B"
    Then I can comment on the comment anonymously