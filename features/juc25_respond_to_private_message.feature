@JUC25 @manual @ui
Feature: JUC25 - Respond to a Private Message

  @JUC25.1 @CISP-156
  Scenario: Participant reads a direct message
    Given I am viewing a list of unread messages in my inbox
    When I select an unread message
    Then it is marked as read and the full message is displayed

  @JUC25.2 @CISP-157
  Scenario: Participant responds to a direct message
    Given I am viewing my inbox
    When I submit a reply to a message
    Then the system sends the reply to the recipient successfully
    And the direct message thread is updated

  @JUC25.3 @CISP-159
  Scenario: Participant responds to a direct message with an internal reference
    Given I am viewing a list of unread messages in my inbox
    When I submit a reply to a message with a reference to internal content
    Then the system sends the reply to the recipient successfully
    And the direct message thread is updated

  @JUC25.4 @CISP-158
  Scenario: Participant responds to a direct message and adds participants to the response
    Given I am viewing a list of unread messages in my inbox
    When I submit a reply to a message with additional participants in the distribution list
    Then the system sends the reply to all recipients successfully
    And the direct message thread is updated
