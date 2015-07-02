Feature: [CISP-605] Author deletes an Uploaded File
#<p>The focus of this test is to cover use case realisation JUC34.1: Author deletes an Uploaded File</p>

  Scenario: Author deletes an Uploaded File
	Given I log in to the CE as an Admin user
	  | [CE admin email and password] |
	Then I am logged in to the CE.
	And I navigate to view an Uploaded File
	  | [An existing file that the User uploaded] |
	Then I am viewing the Uploaded File
	And I select the option to delete the Uploaded File
	Then the system challenges the Author to confirm the deletion request
	And I confirm that I wish to delete the Uploaded File
	Then I have confirmed that I wish to delete the Uploaded File
	And the system deletes the Uploaded File.
	Then the Uploaded File is deleted and can no longer be accessed. All activity stream, inbox and content view references to the file are also removed
