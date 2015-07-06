Feature: Delete upload file
#The focus of this test is to cover use case realisation JUC34.1: Author deletes an Uploaded File

  Scenario: Author deletes an Uploaded File
    Given I am viewing an uploaded document I have recently created
    When I opt to delete the uploaded document
    Then the document is confirmed as deleted
    And can no longer be searched for
