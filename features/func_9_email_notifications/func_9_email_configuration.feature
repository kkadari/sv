@manual
Feature: Email configuration

  Scenario Outline: A user disables HTML notifications globally
    Given I have logged in as "admin"
    When I set the system property "notifications.email.content.allowhtml" to "<value>"
    And I send a direct message to "participant A"
    Then "participant A" will receive a <type> email notification
#
#    Examples:
#    | value | type       |
#    | false | plain text |
#    | true  | HTML       |

  Scenario: A user disables extended notifications globally
    Given I have logged in as "admin"
    When I set the system property "notifications.email.content.extended" to "<value>"
    And I send a direct message to "participant A"
    Then "participant A" will receive a plain text email notification
#
#    Examples:
#    | value |
#    | true  |
#    | false |

  Scenario: A user alters the amount of text in the content settings
    Given I have logged in as "admin"
    When I set the following system properties
      | setting                                                   | value |
      | notifications.email.content.truncation.fallbackproportion | 0.8   |
      | notifications.email.content.truncation.maxlength          | 100   |
      | notifications.email.content.truncation.minlength          | 10	  |
      | notifications.email.content.truncation.targetminlength    | 30	  |
      | notifications.email.content.truncation.targetproportion   | 0.75  |
    And I send a direct message with the following content
      | Cras ultricies ligula sed magna dictum porta. Pellentesque in ipsum id orci porta dapibus. Praesent |
    Then "participant A" will receive an email notification with the a content message of
      | Cras ultricies ligula sed magna dictum porta. Pellentesque in ipsum id orci |
