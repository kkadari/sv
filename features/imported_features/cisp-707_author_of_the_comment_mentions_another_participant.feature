Feature: [CISP-707] Author of the comment mentions another Participant
#<p>This test covers the following use case realisation(s):</p>
#<ul class="alternate" type="square">
#	<li>JUC38.3: Author of the comment mentions another Participant</li>
#</ul>

  Scenario: Author of the comment mentions another Participant
	Given I log in
	  | [User A (a normal user)] |
	And I navigate to an Uploaded File
	Then the System checks that the Uploaded File exists and is valid, the System then displays the Uploaded File metadata and records appropriate metrics to capture the viewing of the Uploaded File. I am presented with the Uploaded File detail screen
	And I click the download link to obtain a local copy of the Uploaded File
	Then system initiates the download of the Uploaded File to the Participant's local machine
	And I select to comment
	  | THIS IS A TEST COMMENT, MENTIONING [@{User B} - PLEASE DISREGARD |
	Then I have added Rich Text to the comment.
	And I submit the comment
	Then the comment is submitted successfully, and the System displays the Uploaded File, inclusive of the newly posted comment
	And I log in
	  | [As User B] |
	And I navigate to my inbox
	Then I am viewing my inbox
	And I have received a notification that I was mentioned in an Uploaded File
	Then my inbox contains an unread message notifying me that I was mentioned in an Uploaed File
