@manual
Feature: File sharing
#JUC31.1: Participant shares a file with the community or sub-set
#JUC32.3: Participant views a preview of an Uploaded File
#JUC31.4: Participant shares a file with the community or sub-set that is not a supported file type
#JUC31.5: Participant shares a file with the community or sub-set that exceeds the maximum file size

  Scenario: Participant shares a file with the community or sub-set
    Given I have logged in as "participant A"
    When I attempt to create an uploaded document with a "word document" attachment
    Then the system validates the upload and creates the uploaded document
    And I can then preview the uploaded document

  Scenario Outline: Participant shares a file with the community or sub-set that fails the AV check
    Given I have logged in as "participant A"
    When I attempt to create an uploaded document with a "<file_type>" attachment
    Then the system validates the upload and rejects it

    Examples:
      | file_type        |
      | malicious        |
      | large file       |
      | unsupported file |
