@JUC38
Feature: JUC38 - Comments on an uploaded file
#JUC38.1: Participant comments on an Uploaded File
#JUC38.2: Participant comments on a comment on an Uploaded File
#JUC38.3: Author of the comment mentions another Participant
#JUC38.4: Author of the comment mentions another Participant in a comment on a comment

  Scenario: Participant comments on an Uploaded File
    Given I am viewing an uploaded document I have recently created
    When I submit a comment for the uploaded document
    Then the comment is submitted successfully and displayed under the uploaded file

  Scenario: Participant comments on a comment on an Uploaded File
    Given I am viewing an uploaded document that has a comment
    When I submit a comment on the original comment
    Then the comment is submitted successfully and displayed under the uploaded file

  Scenario: Author of the comment mentions another Participant in a comment on a comment
    Given I am viewing an uploaded document that has multiple comments as "participant A"
    When I mention "participant B" in a comment on a comment
    And I have logged in as "participant B"
    Then I will receive a notification that I have been mentioned in a comment

  Scenario: Author of the comment mentions another Participant
    Given I have mentioned "participant B" on a uploaded document comment as "participant A"
    When I additionally mention "admin" in the comment
    And I have logged in as "admin"
    Then I will receive a notification that I have been mentioned in a comment
