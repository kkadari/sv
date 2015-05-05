@JUC43
Feature: JUC43 - Edit an Incident

  @JUC43.1 @CISP-246 @CISP-170
  Scenario: Participant edits an amber anonymous incident report
  	Given I have logged in as "participant A"
	When I have quickly raised a red incident report anonymously in a private group
	Then I can edit the anonymous incident report

  @JUC43.2 @CISP-963
  Scenario: Participant updates the IHM for an incident report
  	Given I have logged in as "participant A"
	When I have quickly raised a red incident report anonymously in a private group
	Then I can change incident report marking