Feature: [CISP-636] Participant views and downloads an Uploaded File
#<p>This test covers the following use case realisation(s):</p>
#<ul class="alternate" type="square">
#	<li>JUC32.1: Participant views and downloads an Uploaded File</li>
#	<li>JUC32.2: Participant views the metadata for an Uploaded File</li>
#</ul>

  Scenario: Participant views and downloads an Uploaded File
	Given I log in
	  | CE participant e-mail and password. |
	Then I am logged in to the CE
	And I navigate to an Uploaded File
	Then the System checks that the Uploaded File exists and is valid, the System then displays the Uploaded File metadata and records appropriate metrics to capture the viewing of the Uploaded File. I am presented with the Uploaded File detail screen
	And I click the download link to obtain a local copy of the Uploaded File
	Then system initiates the download of the Uploaded File to the Participant's local machine
