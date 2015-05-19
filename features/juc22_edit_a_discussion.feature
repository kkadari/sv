@JUC22
Feature: JUC22 - Edit a discussion

  @JUC22.1 @CISP-628
  Scenario: Participant updates a discussion
  	Given I have logged in as "admin"
    When I have created a green discussion in the community
    Then I can edit the discussion

  @JUC22.2 @CISP-623
  Scenario: Participant updates the IHM for a discussion
  	Given I have logged in as "admin"
    When I have created a green discussion in the community
    Then I can change the discussion marking