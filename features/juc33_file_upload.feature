@manual
Feature: [CISP-696] Author uploads a new version of a file
#JUC33.1: Author uploads a new version of the file.
#JUC33.2: Author updates the file's metadata.
#JUC33.3: Author attempts to upload a new version of the file that fails an AV check
#JUC33.4: Author attempts to upload a new version of the file that is too big
#JUC33.5: Author attempts to upload a new version of the file that is not a supported file type
#JUC33.6: Author reverts an Uploaded File to a previous version.
#JUC33.7: Author updates the file's IHM.

  Scenario: Author uploads a new version of a file
    Given I am viewing a recently uploaded document with a "word document" attachment
    When I update the uploaded document with a "updated word document" attachment
    Then the system validates the upload and updates the uploaded document
    And I can then preview the uploaded document

  Scenario: Author updates the file's metadata
    Given I am viewing a recently uploaded document with a "word document" attachment
    When I submit an updated metadata for the uploaded documents
    Then the uploaded document's metadata is updated

  Scenario Outline: Participant shares a file with the community or sub-set that fails the AV check
    Given I am viewing a recently uploaded document with a "word document" attachment
    When I attempt to update an uploaded document with a "<file_type>" attachment
    Then the system validates the upload and rejects it

    Examples:
      | file_type        |
      | malicious        |
      | large file       |
      | unsupported file |

  Scenario: Author reverts an Uploaded File to a previous version
    Given I am viewing an uploaded document with multiple versions
    When I opt to revert the uploaded document back to a previous version
    Then the previous version of the uploaded document is displayed
