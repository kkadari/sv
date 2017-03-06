@JUC8
Feature: JUC8 - Comment on a discussion

  @JUC8.1
  Scenario: Participant comments on a discussion
    Given I have logged in as "participant A"
    And I have created an amber discussion in a private group
    When I have logged in as "participant B"
    Then I can comment on the discussion

  @JUC8.2
  Scenario: Participant comments on a comment on a discussion
    Given I have logged in as "participant A"
    And I have created an amber discussion in a private group
	And I have commented on the discussion
	When I have logged in as "participant B"
    Then I can comment on the comment

  @JUC8.3
  Scenario: Participant comments anonymously on a discussion
    Given I have logged in as "participant A"
    And I have created an amber discussion in a private group
    When I have logged in as "participant B"
    Then I can comment on the discussion anonymously

  @JUC8.4
  Scenario: Participant comments anonymously on a comment on a discussion
  	Given I have logged in as "participant A"
    And I have created an amber discussion in a private group
	  And I have commented on the discussion
	  When I have logged in as "participant B"
    Then I can comment on the comment anonymously

  Scenario: Participant comments directly on a Discussion using the Advanced Editor
    Given I have opted to leave a comment on a discussion as "participant A" using the advanced editor
    When I submit a comment with some content
    Then the comment is published successfully
