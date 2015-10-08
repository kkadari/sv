@manual
Feature: Email whitelisting

  Scenario: A user disables the global user whitelist for extended notifications
    Given I have logged in as "admin"
    When I set the system property "notifications.email.content.whitelisted" to "false"
    Then all users will have access to extended notification options in preferences

  Scenario: A user enables and adds a user to the extended notifications user whitelist
    Given I have logged in as "admin"
    When I set the system property "notifications.email.content.whitelisted" to "true"
    And I set the system property "notifications.email.content.whitelistusers" to "stephaniek@surevine"
    Then "participant A" will have access to extended notification options in preferences
    And "participant B" will not have access to extended notification options in preferences

  Scenario: A user observes notifications are subject to a template whitelist and are logged
    Given I have logged in as "admin"
    When I set the system property "notifications.email.templates.whitelist" to "extendedcontent.directmessage"
    And I create a direct message and an incident report for "participant A"
    Then "participant A" will receive an email notification for the direct message but not the incident report
    And the log files will reflect which email has been blocked and which has not