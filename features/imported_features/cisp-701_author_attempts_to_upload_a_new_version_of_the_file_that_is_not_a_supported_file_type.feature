Feature: [CISP-701] Author attempts to upload a new version of the file that is not a supported file type
#<p>This test covers JUC33.5: Author attempts to upload a new version of the file that is not a supported file type</p>

  Scenario: Author attempts to upload a new version of the file that is not a supported file type
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
	And I select a new version of the file from my local machine
	  | [A test file of an acceptable file size, but that is not supported - see: http://dev207:8080/xwiki/bin/view/CISP/Supported+file+types+for+Document+Sharing] |
  	Then I have identified and uploaded a test file. The system checks the file is of a supported file type, and within the file upload limits set by the server, but the system reports a failure to the user.
