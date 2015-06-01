@JUC25 @manual
Feature: JUC25 - Respond to a Private Message

  @JUC25.1 @CISP-156 @manual
  Scenario: Participant reads a direct message
    Given I have logged in as "participant A"
    And I have been sent a direct message
    When I select an unread message
    Then it is marked as read and the full message is displayed

  @JUC25.2 @CISP-157 @manual
  Scenario: Participant responds to a direct message
    Given I have logged in as "participant A"
    And I have been sent a direct message
    When I select to reply to a direct message
    And I submit a reply to the direct message
    Then the system sends the reply to the recipient successfully
    And the direct message thread is updated

  @JUC25.3 @CISP-159 @manual
  Scenario: Participant responds to a direct message with an internal reference
    Given I have logged in as "participant A"
    And I have been sent a direct message
    When I select to reply to a direct message
    And my reply references internal content (e.g. a person or group within the system)
    And I submit a reply to the direct message
    Then the system sends the reply to the recipient successfully
    And the direct message thread is updated

  @JUC25.4 @CISP-158 @manual
  Scenario: Participant responds to a direct message and adds participants to the response
    Given I have logged in as "participant A"
    And I have been sent a direct message
    And I add additional Participants to the distribution list
    When I submit a reply to a direct message
    Then the system sends the reply to all recipients successfully
    And the direct message thread is updated
