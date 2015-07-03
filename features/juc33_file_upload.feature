Feature: [CISP-696] Author uploads a new version of a file
#<p>This test covers JUC33.1	: Author uploads a new version of the file.</p>
#<p>This test covers JUC33.2	: Author updates the file's metadata.</p>
#<p>This test covers JUC33.3: Author attempts to upload a new version of the file that fails an AV check</p>
#<p>This test covers JUC33.4: Author attempts to upload a new version of the file that is too big</p>
#<p>This test covers JUC33.5: Author attempts to upload a new version of the file that is not a supported file type</p>
#<p>This test covers JUC33.6: Author reverts an Uploaded File to a previous version.</p>
#<p>This test covers JUC33.7: Author updates the file's IHM.</p>

  Scenario: Author uploads a new version of a file
    Given I log in
      | [As User A, using CE participant e-mail and password.] |
    And I select the option to Upload a File
    Then I am presented with a form to upload a new file
    And I have identified a local file to upload
      | [A test ZIP file (with <2mb file size] |
    Then the System checks the file is a supported type, and within the file upload limits set by the server, and I have uploaded a test file
    And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution
      | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | Default (Amber) | In a specific place (A Private 'Testing' Group of some sort, as appropriate to the test environment) | QA TEST |
    Then I have populated the relevant fields of the Upload a File form
    And I submit the Upload a File form.
    Then the System uploads the file and virus scans the file, then displays the Uploaded File
    And I click Edit
    Then the System displays the Edit screen for the Uploaded File
    And I select a new version of the file from my local machine
      | [Select an updated version of the original ZIP fie] |
    Then the system checks the file is a supported type, and within the file upload limits set by the server
    And I publish the new version of the Uploaded File
    Then the System uploads the file and virus scans the file
    Then the System records a new version of the Uploaded File details, and makes the new version available to users. The System notifies relevant Participant's that the change has occurred

  Scenario: Author updates the file's metadata
    Given I log in
      | [As User A, using CE participant e-mail and password.] |
    Then I am logged in to the CE
    And I select the option to Upload a File
    Then I am presented with a form to upload a new file
    And I have identified a local file to upload
      | [A test ZIP file (with <2mb file size] |
    Then the System checks the file is a supported type, and within the file upload limits set by the server, and I have uploaded a test file
    And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution
      | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | Default (Amber) | In a specific place (A Private 'Testing' Group of some sort, as appropriate to the test environment) | QA TEST |
    Then I have populated the relevant fields of the Upload a File form
    And I submit the Upload a File form
    Then the System uploads the file and virus scans the file, then displays the Uploaded File
    And I click Edit
    Then the System displays the Edit screen for the Uploaded File
    And I change the Uploaded File's metadata.
      | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard EDIT | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard EDIT | [Change to Green] | {Change to another Private/Secret group} | QA TEST EDIT |
    Then I have changed the Uploaded File's metadata
    And I publish the new version of the Uploaded File
    Then the System records a new version of the Uploaded File details, and makes the new version available to users. The System notifies relevant Participant's that the change has occurred

  Scenario: Author attempts to upload a new version of the file that fails an AV check
    Given I log in
      | CE participant e-mail and password. |
    Then I am logged in to the CE
    And I select the option to Upload a File
    Then I am presented with a form to upload a new file
    And I have identified a local file to upload
      | [A test ZIP file (with <2mb file size] |
    Then the System checks the file is a supported type, and within the file upload limits set by the server, and I have uploaded a test file
    And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution
      | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | Default (Amber) | In a specific place (A Private 'Testing' Group of some sort, as appropriate to the test environment) | QA TEST |
    Then I have populated the relevant fields of the Upload a File form
    And I submit the Upload a File form
    Then the System uploads the file and virus scans the file, then displays the Uploaded File
    And I click Edit
    Then the System displays the Edit screen for the Uploaded File
    And I select a new version of the file from my local machine
      | [A malware test file, e.g. 'eicar.exe' - see http://www.eicar.org/85-0-Download.html] |
    Then I have identified and uploaded a test file that will fail the AV check
    And I submit the Upload a File form
    Then the system checks the file is a supported type, and within the file upload limits set by the server, but the AV check fails, and the system informs the user that the file cannot be uploaded. The user is not permitted to submit the file

  Scenario: Author attempts to upload a new version of the file that is too big
    Given I log in
      | CE participant e-mail and password. |
    And I select the option to Upload a File
    Then I am presented with a form to upload a new file
    And I have identified a local file to upload
      | [A test ZIP file (with <2mb file size] |
    Then the System checks the file is a supported type, and within the file upload limits set by the server, and I have uploaded a test file
    And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution.
      | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | Default (Amber) | In a specific place (A Private 'Testing' Group of some sort, as appropriate to the test environment) | QA TEST |
    Then I have populated the relevant fields of the Upload a File form.
    And I submit the Upload a File form.
    Then the System uploads the file and virus scans the file, then displays the Uploaded File.
    And I click Edit
    Then the System displays the Edit screen for the Uploaded File.
    And I select a new version of the file from my local machine
      | [A test file of an acceptable file type, but that exceeds the acceptable system limit. See: http://dev207:8080/xwiki/bin/view/CISP/Uploaded+file+size] |
    Then I have identified and uploaded a test file.
    And I submit the Upload a File form.
    Then the system checks the file is a supported type, and within the file upload limits set by the server, but the system reports a failure to the user. The Uploaded File is not persisted in the System.

  Scenario: Author attempts to upload a new version of the file that is not a supported file type
    Given I log in
      | CE participant e-mail and password. |
    Then I am logged in to the CE
    And I select the option to Upload a File
    Then I am presented with a form to upload a new file
    And I have identified a local file to upload
      | [A test ZIP file (with <2mb file size] |
    Then I identified and uploaded a test file
    And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution
      | Title: {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | Default (Amber) | In a specific place (A Private 'Testing' Group of some sort, as appropriate to the test environment) | QA TEST |
    Then I have populated the relevant fields of the Upload a File form
    And I submit the Upload a File form
    Then the System uploads the file and virus scans the file, then displays the Uploaded File
    And I click Edit
    Then the System displays the Edit screen for the Uploaded File
    And I select a new version of the file from my local machine
      | [A test file of an acceptable file size, but that is not supported - see: http://dev207:8080/xwiki/bin/view/CISP/Supported+file+types+for+Document+Sharing] |
    Then I have identified and uploaded a test file. The system checks the file is of a supported file type, and within the file upload limits set by the server, but the system reports a failure to the user.

  Scenario: Author reverts an Uploaded File to a previous version
    Given I log in
      | CE participant e-mail and password. |
    Then I am logged in to the CE
    And I select the option to Upload a File
    Then I am presented with a form to upload a new file
    And I have identified a local file to upload
      | [A test ZIP file (with <2mb file size] |
    Then I identified and uploaded a test file
    And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution
      | Title: {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | Default (Amber) | In a specific place (A Private 'Testing' Group of some sort, as appropriate to the test environment) | QA TEST |
    Then I have populated the relevant fields of the Upload a File form.
    And I submit the Upload a File form.
    Then the System uploads the file and virus scans the file, then displays the Uploaded File.
    And I click Edit
    Then the System displays the Edit screen for the Uploaded File.
    And I select to view previous versions of an Uploaded File.
    Then the System displays previous versions of the Uploaded File.
    And I choose one of the previous versions of the Uploaded File to become the current version
      | [Previous Version] |
    Then the System reverts the Uploaded File to the previous version, then displays the current (previous) version of the Uploaded File.

  Scenario: Author updates the file's IHM
    Given I log in
      | CE participant e-mail and password. |
    Then I am logged in to the CE
    And I select the option to Upload a File
    Then I am presented with a form to upload a new file
    And I have identified a local file to upload
      | [A test ZIP file (with <2mb file size] |
    Then I identified and uploaded a test file
    And I add metadata to the Uploaded File (specifying a title, a description/summary and optionally setting some tags), IHM level and distribution
      | Title: {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | {Today's Date}-{Current 24-hour Time}: Test Upload File: ZIP - Please disregard | Default (Amber) | In a specific place (A Private 'Testing' Group of some sort, as appropriate to the test environment) | QA TEST |
    Then I have populated the relevant fields of the Upload a File form
    And I submit the Upload a File form
    Then the System uploads the file and virus scans the file, then displays the Uploaded File
    And I click Edit
    Then the System displays the Edit screen for the Uploaded File
    And I elect to change the Uploaded File's IHM
      | Change from default (or existing) to a different IHM level. |
    Then I have changed the Upload File's IHM and the System displays the Uploaded File

