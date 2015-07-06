Feature: [CISP-636] Participant views and downloads an Uploaded File
#JUC32.1: Participant views and downloads an Uploaded File
#JUC32.2: Participant views the metadata for an Uploaded File
#JUC32.4: Participant attempts to view an Uploaded File that has been deleted
#JUC32.5: Participant views an uploaded file directly
#JUC32.6: Participant attempts to view an Uploaded File directly, that they don't have access to

  Scenario: Participant views and downloads an Uploaded File
    Given I am viewing an uploaded file as "participant A"
    When I select to download the attached file
    Then the attached file is downloaded

  Scenario: Participant attempts to view an Uploaded File that has been deleted
    Given there is an uploaded document that has been recently deleted
    When I attempt to view it as "participant A"
    Then I am returned a page informing me the document isn't available

  Scenario: Participant views an uploaded file directly
    Given there is an uploaded document that has been recently created
    When I navigate to the uploaded document directly
    Then I am returned the uploaded document

  Scenario: Participant attempts to view an Uploaded File directly, that they don't have access to
    Given there is an uploaded document that has been recently created for a secret group
    When I attempt to view the uploaded document with a user that is not a member of the secret group
    Then I am returned a page informing me the document isn't available
