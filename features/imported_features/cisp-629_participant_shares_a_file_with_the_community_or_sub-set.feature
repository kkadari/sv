Feature: [CISP-629] Participant shares a file with the community or sub-set
#<p>This test covers JUC31.1: Participant shares a file with the community or sub-set</p>
#<p>This test variant is publishing a zip file (non-preview) to a Private Group. </p>

  Scenario: Participant shares a file with the community or sub-set
	Given I log in
	  | CE participant e-mail and password. |
	Then I am logged in to the CE
	And I select the option to Upload a File
	Then I am presented with a form to upload a new file
	And I have identified a local file to upload
	  | [A test Word document (with <2mb file size] |
	Then I identified and uploaded a test file
	And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution
	  | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | {Today's Date}-{Current 24-hour Time}: Test Upload File: DOCX - Please disregard | Default (Amber) | In a specific place (A Private 'Testing' Group of some sort, as appropriate to the test environment) | QA TEST |
	Then I have populated the relevant fields of the Upload a File form
	When I submit the Upload a File form
	Then the system checks the file is a supported type, and within the file upload limits set by the server, then uploads the file and virus scans the file, then displays the Uploaded File
