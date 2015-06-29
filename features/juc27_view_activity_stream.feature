@JUC27
Feature: JUC27 - View an Activity Stream

  @JUC27.1 @CISP-254
  Scenario: Activity stream doesn't leak an anonymously posted incident report
    Given I have logged in as "participant A"
	And I have quickly raised a white incident report anonymously in a private group
    Then another user is not able to view it in my activity stream

  @JUC27.1 @CISP-258
	Scenario: Activity stream doesn't leak an anonymously posted incident report
	Given I have logged in as "participant A"
	And I have quickly raised a green incident report anonymously in a private group
	And I can edit the anonymous incident report
	When I have logged in as "participant B"
	And another user is not able to view it in my activity stream

  @JUC27.2 @CISP-255
  Scenario: Activity stream doesn't leak an anonymously posted comment on incident report
	Given I have logged in as "participant B"
    And I have quickly raised an amber incident report in a private group
    And I have commented on the incident report anonymously
    When I have logged in as "participant A"
	Then I am not able to view their identity on the comment in their activity stream

  @JUC27.3 @CISP-607
  Scenario: Activity stream does not leak anonymous content posted in a shared group
    Given a participant has raised an anonymous incident report in a group I follow in my connections stream
    Then I can verify the incident report is marked anonymous in my connection stream
