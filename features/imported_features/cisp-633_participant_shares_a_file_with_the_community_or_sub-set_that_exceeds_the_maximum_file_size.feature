Feature: [CISP-633] Participant shares a file with the community or sub-set that exceeds the maximum file size
#<p>This test covers JUC31.5: Participant shares a file with the community or sub-set that exceeds the maximum file size.</p>

  Scenario: Participant shares a file with the community or sub-set that exceeds the maximum file size
	Given I log in
	  | CE participant e-mail and password. |
	Then I am logged in to the CE.
	And I select the option to Upload a File
	Then I am presented with a form to upload a new file
	And I have identified a local file to upload
	  | [A test file of an acceptable file type, but that exceeds 5mb] |
	Then I have identified and uploaded a test file
	And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution.
	  | {Today's Date}-{Current 24-hour Time}: Test Upload File - Please disregard | {Today's Date}-{Current 24-hour Time}: Test Upload File - Please disregard | Default (Amber) | In a specific place (A Private 'Testing' Group of some sort, as appropriate to the test environment) | QA TEST |
	Then I have populated the relevant fields of the Upload a File form
	And I submit the Upload a File form
	Then the system checks the file is a supported type, and within the file upload limits set by the server, but the system reports a failure to the user. The Uploaded File is not persisted in the System
