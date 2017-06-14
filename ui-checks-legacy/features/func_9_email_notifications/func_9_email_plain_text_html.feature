@manual
Feature: Toggle plain text / html email

  Scenario: User enables plain text notifications in preferences
    Given I am logged in as 'participant A'
    And I have opted to receive plain text email notifications in preferences
    When I mention 'participant A' in a comment as 'participant B'
    Then 'participant A' will receive a plain text notification email

  Scenario: User enables HTML notifications in preferences
    Given I am logged in as 'participant A'
    And I have opted to receive HTML email notifications in preferences
    When I mention 'participant A' in a comment as 'participant B'
    Then 'participant A' will receive an HTML notification email
