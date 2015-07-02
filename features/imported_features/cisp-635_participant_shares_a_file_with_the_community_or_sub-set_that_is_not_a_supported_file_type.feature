Feature: [CISP-635] Participant shares a file with the community or sub-set that is not a supported file type
#<p>This test covers JUC31.4: Participant shares a file with the community or sub-set that is not a supported file type</p>

  Scenario: Participant shares a file with the community or sub-set that is not a supported file type
	Given I log in
	  | CE participant e-mail and password. |
	Then I am logged in to the CE
	And I select the option to Upload a File
	Then I am presented with a form to upload a new file
	And I have identified and selected a local file to upload
	  | [A test file of an acceptable file size, but that is not supported - see: http://dev207:8080/xwiki/bin/view/CISP/Supported+file+types+for+Document+Sharing] |
	Then I have identified and uploaded a test file. The system checks the file is of a supported file type, and within the file upload limits set by the server, but the system reports a failure to the user
