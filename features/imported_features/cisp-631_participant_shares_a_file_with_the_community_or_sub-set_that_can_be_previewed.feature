Feature: [CISP-631] Participant shares a file with the community or sub-set that can be previewed
#<p>This test covers the following use case realisation(s):</p>
#
#<ul class="alternate" type="square">
#	<li>JUC31.1: Participant shares a file with the community or sub-set</li>
#	<li>JUC32.3: Participant views a preview of an Uploaded File</li>
#</ul>
#
#
#<p>This test variant is publishing to a Secret Group. </p>

  Scenario: Participant shares a file with the community or sub-set that can be previewed
	Given I log in
	  | CE participant e-mail and password. |
	Then I am logged in to the CE
	And I select the option to Upload a File
	Then I am presented with a form to upload a new file
	And I have identified a local file to upload
	  | [A test Word Document (newer versions) file (with <2mb file size] |
	Then I identified and uploaded a test file
	And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution.
	  | {Today's Date}-{Current 24-hour Time}: Test Upload File: Word (New) - Please disregard | {Today's Date}-{Current 24-hour Time}: Test Upload File: Word (New) - Please disregard | Default (Amber) | In a specific place (A Secret 'Testing' Group of some sort, as appropriate to the test environment) | QA TEST |
	Then I have populated the relevant fields of the Upload a File form
	And I submit the Upload a File form
	Then the system checks the file is a supported type, and within the file upload limits set by the server, then uploads the file and virus scans the file, then displays the Uploaded File. The system also generates a preview of the file to be displayed alongside the Uploaded File's metadata

