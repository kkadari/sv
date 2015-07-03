@JUC8
Feature: JUC8 - Comment on a discussion
#<p>This test was written to cover JUC8.1 - Participant comments directly to a Discussion </p>

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

  Scenario: Participant comments directly on a Discussion using the Advanced Editor
    Given I log in
      | CE participant e-mail and password. |
    And I have identified an existing Discussion I wish to view within the system
      | {pre-existing content that the user has not authored} |
    Then I have identified an existing Discussion that exists within the CE
    And I select to view the Discussion
    Then I have selected to view the Discussion
    And the system checks that the Discussion exists and is valid
    Then the system displays the discussion and records appropriate metrics to capture the viewing of the discussion
    And I select the option to reply directly to the Discussion
    Then the System presents a Rich Text Editor that can be populated
    And I opt to use the Advanced Editor
    Then I am navigated to a page containing the existing IHM marking for the discussion, a rich text editor, the content being replied to, and the option to mark the Discussion as anonmyous
    And I populate the rich text editor and submit the form (without marking the post as Anonymous)
      | {date}-{hh:mm} - TEST COMMENT - PLEASE DISREGARD |
    Then the comment is published successfully and the System displays the newly created comment on the Discussion.
