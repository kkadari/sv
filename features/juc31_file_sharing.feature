Feature: File sharing
#<p>This test covers JUC31.1: Participant shares a file with the community or sub-set</p>
#<ul class="alternate" type="square">
#<p>This test covers JUC31.3: Participant shares a file with the community or sub-set that exceeds the maximum file size.</p>
#	<li>JUC31.1: Participant shares a file with the community or sub-set</li>
#	<li>JUC32.3: Participant views a preview of an Uploaded File</li>
#</ul>
#<p>This test covers JUC31.4: Participant shares a file with the community or sub-set that is not a supported file type</p>
#<p>This test covers JUC31.5: Participant shares a file with the community or sub-set that exceeds the maximum file size.</p>

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

  Scenario: Participant shares a file with the community or sub-set that is not a supported file type
    Given I log in
      | CE participant e-mail and password. |
    Then I am logged in to the CE
    And I select the option to Upload a File
    Then I am presented with a form to upload a new file
    And I have identified and selected a local file to upload
      | [A test file of an acceptable file size, but that is not supported - see: http://dev207:8080/xwiki/bin/view/CISP/Supported+file+types+for+Document+Sharing] |
    Then I have identified and uploaded a test file. The system checks the file is of a supported file type, and within the file upload limits set by the server, but the system reports a failure to the user
