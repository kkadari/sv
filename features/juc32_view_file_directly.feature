Feature: [CISP-636] Participant views and downloads an Uploaded File
#<p>This test covers the following use case realisation(s):</p>
#<ul class="alternate" type="square">
#	<li>JUC32.1: Participant views and downloads an Uploaded File</li>
#	<li>JUC32.2: Participant views the metadata for an Uploaded File</li>
#<p>This test covers JUC32.4: Participant attempts to view an Uploaded File that has been deleted</p>
#<p>This test covers JUC32.5: Participant views an uploaded file directly</p>
#<p>This test covers JUC32.6: Participant attempts to view an Uploaded File directly, that they don't have access to</p>
#</ul>

  Scenario: Participant views and downloads an Uploaded File
    Given I log in
      | CE participant e-mail and password. |
    Then I am logged in to the CE
    And I navigate to an Uploaded File
    Then the System checks that the Uploaded File exists and is valid, the System then displays the Uploaded File metadata and records appropriate metrics to capture the viewing of the Uploaded File. I am presented with the Uploaded File detail screen
    And I click the download link to obtain a local copy of the Uploaded File
    Then system initiates the download of the Uploaded File to the Participant's local machine

  Scenario: Participant attempts to view an Uploaded File that has been deleted
    Given I log in
      | [As Admin] |
    And I select the option to Upload a File
    Then I am presented with a form to upload a new file.
    And I have identified a local file to upload
      | [Any acceptable file] |
    Then I identified and uploaded a test file.
    And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution
      | {Today's Date}-{Current 24-hour Time}: Test Upload File - Please disregard | Test Upload File - Please disregard | {Default - Amber} | {The CISP Community} | QA, TEST |
    Then I have populated the relevant fields of the Upload a File form.
    And I submit the Upload a File form.
    Then the system checks the file is a supported type, and within the file upload limits set by the server, then uploads the file and virus scans the file, then displays the Uploaded File.
    And I navigate to an Uploaded File
    Then the System checks that the Uploaded File exists and is valid, the System then displays the Uploaded File metadata and records appropriate metrics to capture the viewing of the Uploaded File. I am presented with the Uploaded File detail screen.
    And I keep a record of the Uploaded File URL.
      | [You'll need this in a second!] |
    Then I have recorded the Uploaded File URL.
    And I select the option to and confirm to Delete the Uploaded File
    Then the Uploaded File is deleted.
    And I log in
      | [As User A (a normal user)] |
    And I navigate to an Uploaded File that has been deleted.
      | [URL from previous steps] |
    Then the System displays a message notifying the Participant that the Uploaded File isn't available.
      | [As User A] |

  Scenario: Participant views an uploaded file directly
    Given I log in
      | [As Admin] |
    Then I am logged in to the CE.
    And I select the option to Upload a File
    Then I am presented with a form to upload a new file.
    And I have identified a local file to upload
      | [Any acceptable file] |
    Then I identified and uploaded a test file.
    And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution.
      | {Today's Date}-{Current 24-hour Time}: Test Upload File - Please disregard |
    Then I have populated the relevant fields of the Upload a File form.
    And I submit the Upload a File form.
    Then the system checks the file is a supported type, and within the file upload limits set by the server, then uploads the file and virus scans the file, then displays the Uploaded File.
    And I navigate to an Uploaded File
    Then the System checks that the Uploaded File exists and is valid, the System then displays the Uploaded File metadata and records appropriate metrics to capture the viewing of the Uploaded File. I am presented with the Uploaded File detail screen.
    And I keep a record of the Uploaded File URL.
      | [You'll need this in a second!] |
    Then I have recorded the Uploaded File URL.
    And I log in
      | [As User A (a normal user)] |
    When I enter the URL for the Uploaded File directly into their browser.
      | [URL from previous steps] |
    Then the System checks that the Uploaded File exists and is valid, the System then displays the Uploaded File metadata and records appropriate metrics to capture the viewing of the Uploaded File. I am presented with the Uploaded File detail screen.
      | [As User A] |

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
