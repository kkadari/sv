Feature: [CISP-141] Participant exports an incident report to PDF containing various heading styles

Scenario: Participant exports an incident report to PDF containing various heading styles
	Given I log in
		|  CE participant email and password  |
	And I create an incident report
	Then the incident report is visible with correct formatting from Step 2 test data
	And I export the incident report to PDF
	Then I can view the PDF with all applicable heading data from step 2 correctly formatted (see attached screenshot for reference)
