Feature: [CISP-161] Participant exports an incident report after changing their time zone preferences

  Scenario: Participant exports an incident report after changing their time zone preferences
	Given I log in
		| CE participant email and password |
	And I navigate to my user Preferences screen
	Then I am viewing my Preferences
	And I alter my Time Zone
		| Change it from GMT to something more exotic (+/- 4 hours) |
	And submit changes to my preferences
	Then my preferences are saved
	And view an incident report
		| Any IR that the CE participant has access to. |
	Then the incident report is visible
	And export an incident report to PDF
	Then the incident report is exported to PDF and is displayed and the timestamp displayed in the PDF header (Shared in...), comment(s), and footer is adjusted for my Time Zone preferences.
