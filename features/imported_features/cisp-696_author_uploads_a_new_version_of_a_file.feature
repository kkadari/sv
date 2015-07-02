Feature: [CISP-696] Author uploads a new version of a file
#<p>This test covers JUC33.1	: Author uploads a new version of the file.</p>
#<p>This test variant is publishing a zip file (non-preview) to a Private Group. </p>

  Scenario: Author uploads a new version of a file
	Given I log in
	  | [As User A, using CE participant e-mail and password.] |
	And I select the option to Upload a File
	Then I am presented with a form to upload a new file
	And I have identified a local file to upload
	  | [A test ZIP file (with <2mb file size] |
	Then the System checks the file is a supported type, and within the file upload limits set by the server, and I have uploaded a test file
	And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution
	  | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | Default (Amber) | In a specific place (A Private 'Testing' Group of some sort, as appropriate to the test environment) | QA TEST |
	Then I have populated the relevant fields of the Upload a File form
	And I submit the Upload a File form.
	Then the System uploads the file and virus scans the file, then displays the Uploaded File
	And I click Edit
	Then the System displays the Edit screen for the Uploaded File
	And I select a new version of the file from my local machine
	  | [Select an updated version of the original ZIP fie] |
	Then the system checks the file is a supported type, and within the file upload limits set by the server
	And I publish the new version of the Uploaded File
	Then the System uploads the file and virus scans the file
	Then the System records a new version of the Uploaded File details, and makes the new version available to users. The System notifies relevant Participant's that the change has occurred
