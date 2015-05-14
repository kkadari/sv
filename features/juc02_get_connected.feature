@JUC2 @quarantine
Feature: JUC2 - Get Connected

  @JUC2.1 @CISP-358 @manual
  Scenario: Participant forms a relationship with another Participant
    Given I have logged in as "participant A"
    And I am not following "participant B"
    When I select to follow "participant B"
    And "participant B" has accepted the connection request
    Then "participant A" is now a follower of "participant B"

  @JUC2.2 @CISP-522 @manual
  Scenario: Participant requests to follow another Participant but this is rejected
    Given I have logged in as "participant A"
    And I am not following "participant B"
    When I select to follow "participant B"
    And "participant B" rejects the connection request
    Then I receive a notification that I have not been added as [user B's] connection
    And "participant B" is not listed as a follower of "participant B"

  @JUC2.3 @CISP-523 @manual
  Scenario: Participant severs a connection with another Participant
    Given I have logged in as "participant A"
    And I am following "participant B"
    When I select to stop following "participant B"
    And "participant B" rejects the connection request
    Then the connection is severed, and I am no longer following "participant B"
    
