Feature: [CISP-702] Author updates the file's IHM
#<p>This test covers JUC33.7: Author updates the file's IHM.</p>

  Scenario: Author updates the file's IHM
	Given I log in
	  | CE participant e-mail and password. |
	Then I am logged in to the CE
	And I select the option to Upload a File
	Then I am presented with a form to upload a new file
	And I have identified a local file to upload
	  | [A test ZIP file (with <2mb file size] |
	Then I identified and uploaded a test file
	And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution
	  | Title: {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | Default (Amber) | In a specific place (A Private 'Testing' Group of some sort, as appropriate to the test environment) | QA TEST |
	Then I have populated the relevant fields of the Upload a File form
	And I submit the Upload a File form
	Then the System uploads the file and virus scans the file, then displays the Uploaded File
	And I click Edit
	Then the System displays the Edit screen for the Uploaded File
	And I elect to change the Uploaded File's IHM
	  | Change from default (or existing) to a different IHM level. |
	Then I have changed the Upload File's IHM and the System displays the Uploaded File
