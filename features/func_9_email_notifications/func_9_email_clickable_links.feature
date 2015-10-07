@manual
Feature: Clickable links in email

  Scenario Outline: User enables clickable links
    Given I have logged in as "particpant A"
    When I have opted to enable clickable links in <type> email notifications
    And I receive a direct message from "participant B"
    Then I will receive an email notification with clickable links

    Examples:
      | type       |
      | HTML       |
      | plain text |

  Scenario Outline: User disables clickable links
    Given I have logged in as "particpant A"
    When I have opted to disable clickable links in <type> email notifications
    And I receive a direct message from "participant B"
    Then I will receive an email notification with links that are not clickable

    Examples:
      | type       |
      | HTML       |
      | plain text |
