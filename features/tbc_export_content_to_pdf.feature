@quarantine
Feature: TBC - Participant exports content to PDF

  @CISP-161
  Scenario: Participant can export IR PDF with correct time stamp after changing time one preferences
    Given I have logged in as "participant A" 
    And I have raised a red incident report in a private group
	When I have changed my time zone preferences
	Then I can export the ir to PDF with the correct timestamp

  @CISP-168
  Scenario: Participant can export discussion PDF with correct time stamp after changing time one preferences
    Given I have logged in as "participant A"
    And I have created a green discussion in a private group
	When I have changed my time zone preferences
	Then I can export the discussion to PDF with the correct timestamp
	
  @CISP-169
  Scenario: Participant can export blog to PDF with correct time stamp after changing time one preferences
    Given I have logged in as "participant A"
    And I have created an amber blog post in a private group
	When I have changed my time zone preferences
	Then I can export the blog to PDF with the correct timestamp
	
  @CISP-141
  Scenario: Participant can export PDF with correct formatting of headings
    Given I have logged in as "participant A"
    When I have raised an white anonymous incident report with various heading styles
	Then I can export to PDF with the correct formatting

  Scenario: Participant can export a blog to PDF
    Given I have logged in as "participant A"
    And I have created an amber blog post in a private group
	Then I export the blog to PDF

  Scenario: Participant can export a discussion to PDF
    Given I have logged in as "participant A"
    And I have created an amber discussion in a private group
	Then I export the discussion to PDF

  Scenario: Participant can export an incident report to PDF
    Given I have logged in as "participant A"
    And I have raised an amber incident report in a private group
	Then I export the incident report to PDF