@JUC42 @manual
Feature: JUC42 - Submit Group Creation Request
#JUC42.1: CE Participant submits Group Creation Request form successfully.</li>
#JUC42.2: CE Participant does not complete all Group Creation Request mandatory fields</li>

  @JUC42.1 @CISP-999 @quarantine
  Scenario: Participant submits form successfully
    Given I have logged in as "participant A"
    And I have requested a new group is created with an additional owner and a supporter
    When I have logged in as "admin"
    Then I have received the group creation request in my inbox

  @JUC4.2
  Scenario: CE Participant does not complete all Group Creation Request mandatory fields
    Given I have opted to request a new group
    When I leave the mandatory fields blank
    And attempted to submit the request
    Then I will receive validation errors for the missing content
