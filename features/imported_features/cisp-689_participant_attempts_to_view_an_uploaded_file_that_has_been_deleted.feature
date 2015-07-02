Feature: [CISP-689] Participant attempts to view an Uploaded File that has been deleted
#<p>This test covers JUC32.4: Participant attempts to view an Uploaded File that has been deleted</p>

  Scenario: Participant attempts to view an Uploaded File that has been deleted
	Given I log in
	  | [As Admin] |
	And I select the option to Upload a File
	Then I am presented with a form to upload a new file.
	And I have identified a local file to upload
	  | [Any acceptable file] |
	Then I identified and uploaded a test file.
	And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution
	  | {Today's Date}-{Current 24-hour Time}: Test Upload File - Please disregard | Test Upload File - Please disregard | {Default - Amber} | {The CISP Community} | QA, TEST |
	Then I have populated the relevant fields of the Upload a File form.
	And I submit the Upload a File form.
	Then the system checks the file is a supported type, and within the file upload limits set by the server, then uploads the file and virus scans the file, then displays the Uploaded File.
	And I navigate to an Uploaded File
	Then the System checks that the Uploaded File exists and is valid, the System then displays the Uploaded File metadata and records appropriate metrics to capture the viewing of the Uploaded File. I am presented with the Uploaded File detail screen.
	And I keep a record of the Uploaded File URL.
	  | [You'll need this in a second!] |
	Then I have recorded the Uploaded File URL.
	And I select the option to and confirm to Delete the Uploaded File
	Then the Uploaded File is deleted.
	And I log in
	  | [As User A (a normal user)] |
	And I navigate to an Uploaded File that has been deleted.
	  | [URL from previous steps] |
	Then the System displays a message notifying the Participant that the Uploaded File isn't available.
	  | [As User A] |
