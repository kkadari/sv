@JUC24 @manual
Feature: JUC24 - Send a Private Message

  @JUC24.1 @CISP-155
  Scenario: Participant wants to directly message two or more Participants with an Internal Reference
    Given I have opted to create a direct message logged in as "participant A"
    When I reference internal content and people in the body
    And I send the direct message to two participants
    Then both participants receive the direct message
    And the e-mail notification does not contain body content
