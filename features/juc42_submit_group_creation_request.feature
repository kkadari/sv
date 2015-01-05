@JUC42
Feature: JUC42 - Submit Group Creation Request

  @JUC42.1 @CISP-999 @quarantine
  Scenario: Participant submits form successfully
    Given I have logged in as "participant A"
    And I have requested a new group is created with an additional owner and a supporter
    # When I have logged in as "admin"
    # Then I have received the group creation request in my inbox