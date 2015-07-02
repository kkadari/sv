Feature: [CISP-632] Participant shares a file with the community or sub-set that fails the AV check
#<p>This test covers JUC31.3: Participant shares a file with the community or sub-set that exceeds the maximum file size.</p>

  Scenario: Participant shares a file with the community or sub-set that fails the AV check
	Given Given I log in
	  | CE participant e-mail and password. |
	Then I am logged in to the CE.
	And I select the option to Upload a File
	Then I am presented with a form to upload a new file
	And I have identified a local file to upload
	  | [A malware test file, e.g. 'eicar.exe' - see http://www.eicar.org/85-0-Download.html] |
	Then I have identified and uploaded a test file
	And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution.
	  | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | Default (Amber) | In a specific place (A Private 'Testing' Group of some sort, as appropriate to the test environment) | QA TEST |
	Then I have populated the relevant fields of the Upload a File form
	When I submit the Upload a File form.
	Then the system checks the file is a supported type, and within the file upload limits set by the server, but the AV check fails, and the system informs the user that the file cannot be uploaded. The user is not permitted to submit the file
