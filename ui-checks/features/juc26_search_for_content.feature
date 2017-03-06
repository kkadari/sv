@JUC26
Feature: JUC26 - Search for content

  Scenario: Participant searches for another participant
    Given I have logged in as "participant A"
    And I have used spotlight search to search for a participant
    Then details for that participant are returned by Jive search

  @JUC26.1
  Scenario: Participant searches for anonymous incident report
    Given I have logged in as "participant A"
    And I have raised a white incident report anonymously in a private group
    When I have logged in as "participant B"
	  Then I can use Jive search to find the anonymous incident report

  @JUC26.1
  Scenario: Participant searches for incident report with anonymous comment
    Given I have logged in as "participant B"
    And I have raised an amber incident report in a private group
    And I have commented on the incident report anonymously
    When I have logged in as "participant A"
    Then I am not able to view their identity on the comment when I search for the incident report

  @JUC26.2
  Scenario: Admin searches for anonymous incident report
	  Given I have logged in as "participant A"
	  And I have raised a white incident report anonymously in a private group
  	When I have logged in as "admin"
  	Then I can use Jive search to find the anonymous incident report

  @JUC26.3
  Scenario: Author searches for anonymous incident report
  	Given I have logged in as "participant A"
    And I have raised an amber incident report anonymously in a private group
  	Then I can use Jive search to find the anonymous incident report

  @JUC26.6
  Scenario: Participant searches for incident report by ID using search page
    Given I have logged in as "participant A"
    When I have raised an amber incident report anonymously in a private group
    Then I can use the spotlight search to find the incident report by ID
