@JUC2
Feature: JUC2 - Get Connected

  Background:
    Given that "participant A" and "participant B" are not following one another

  @JUC2.1
  Scenario: Participant forms a relationship with another Participant
    Given I have logged in as "participant A"
    And I select to follow "participant B"
    When "participant B" accepts the connection request
    Then "participant A" will get a confirmation that "participant B" has accepted my request

  @JUC2.2
  Scenario: Participant requests to follow another Participant but this is rejected
    Given I have logged in as "participant A"
    And I select to follow "participant B"
    When "participant B" rejects the connection request
    Then "participant A" will receive a notification that my request has not been accepted
    And "participant A" is not listed as a follower of "participant B"

  @JUC2.3
  Scenario: Participant severs a connection with another Participant
    Given I have logged in as "participant A"
    And I am following "participant B"
    When I sever the connection with "participant B" as "participant A"
    Then "participant A" is not listed as a follower of "participant B"
