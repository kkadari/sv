Feature: [CISP-705] Participant comments on a comment on an Uploaded File
#<p>This test covers the following use case realisation(s):</p>
#<ul class="alternate" type="square">
#	<li>JUC38.2: Participant comments on a comment on an Uploaded File</li>
#</ul>

  Scenario: Participant comments on a comment on an Uploaded File
	Given I log in
	  | [User A (a normal user)] |
	Then I am logged in to the CE
	And I navigate to an Uploaded File
	Then the System checks that the Uploaded File exists and is valid, the System then displays the Uploaded File metadata and records appropriate metrics to capture the viewing of the Uploaded File. I am presented with the Uploaded File detail screen
	And I click the download link to obtain a local copy of the Uploaded File
	Then system initiates the download of the Uploaded File to the Participant's local machine
	And I select to comment
	  | THIS IS A TEST COMMENT - PLEASE DISREGARD |
	Then I have added Rich Text to the comment
	And I submit the comment
	Then the comment is submitted successfully, and the System displays the Uploaded File, inclusive of the newly posted comment
	And I log in
	  | [As User B (a normal user)] |
	And I navigate to an Uploaded File
	  | [The same Uploaded File commented on in the steps above] |
	Then the System checks that the Uploaded File exists and is valid, the System then displays the Uploaded File metadata and records appropriate metrics to capture the viewing of the Uploaded File. I am presented with the Uploaded File detail screen
	And I select to comment
	  | THIS IS ANOTHER TEST COMMENT - PLEASE DISREGARD |
	Then I have added Rich Text to the comment
	And I submit the comment
	Then the comment is submitted successfully, and the System displays the Uploaded File, inclusive of the newly posted comment
