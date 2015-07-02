Feature: [CISP-693] Participant attempts to view an Uploaded File directly, that they don't have access to
#<p>This test covers JUC32.6: Participant attempts to view an Uploaded File directly, that they don't have access to</p>

  Scenario: Participant attempts to view an Uploaded File directly, that they don't have access to
	Given I log in
	  | [As User A] |
	Then I am logged in to the CE.
	And I select the option to Upload a File
	Then I am presented with a form to upload a new file
	And I have identified a local file to upload
	  |  [Any acceptable file]  |
	Then I identified and uploaded a test file
	And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution
	  | Title: {Today's Date}-{Current 24-hour Time}: Test Upload File - Please disregard Publication: In a space/group [User B] does not have access to. |
	Then I have populated the relevant fields of the Upload a File form
	And I submit the Upload a File form
	Then the system checks the file is a supported type, and within the file upload limits set by the server, then uploads the file and virus scans the file, then displays the Uploaded File
	And I navigate to an Uploaded File
	Then the System checks that the Uploaded File exists and is valid, the System then displays the Uploaded File metadata and records appropriate metrics to capture the viewing of the Uploaded File. I am presented with the Uploaded File detail screen
	And I keep a record of the Uploaded File URL
	  | [You'll need this in a second!] |
	Then I have recorded the Uploaded File URL
	And I log in
	  | [As User B (another normal user)] |
	When I enter a URL for an Uploaded File directly into their browser that I don't have access to
	  | [URL from previous steps] |
	Then the System displays a message notifying the Participant that the Uploaded File isn't available
	  | [As User B] |
