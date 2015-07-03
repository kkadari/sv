@JUC2 @quarantine
Feature: JUC2 - Get Connected

  @JUC2.1 @CISP-358 @manual
  Scenario: Participant forms a relationship with another Participant
    Given I have logged in as "participant A"
    And I select to follow "participant B"
    When "participant B" accepts the connection request
    Then I will get a confirmation that "participant B" has accepted my request

  @JUC2.2 @CISP-522 @manual
  Scenario: Participant requests to follow another Participant but this is rejected
    Given I have logged in as "participant A"
    And I select to follow "participant B"
    When "participant B" rejects the connection request
    Then I will receive a notification that my request has not been accepted
    And "participant B" is not listed as a follower

  @JUC2.3 @CISP-523 @manual
  Scenario: Participant severs a connection with another Participant
    Given I have logged in as "participant A"
    And I am following "participant B"
    When "participant B" severs the connection with me
    Then "participant B" is no longer listed as a follower