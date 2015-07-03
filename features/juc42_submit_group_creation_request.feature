@JUC42
Feature: JUC42 - Submit Group Creation Request
#<p>The focus of this test is to cover the following use case realisation: </p>
#<ul class="alternate" type="square">
#	<li>JUC42.1: CE Participant submits Group Creation Request form successfully.</li>
#   <li>JUC42.2: CE Participant does not complete all Group Creation Request mandatory fields</li>
#</ul>

  @JUC42.1 @CISP-999 @quarantine
  Scenario: Participant submits form successfully
    Given I have logged in as "participant A"
    And I have requested a new group is created with an additional owner and a supporter
    When I have logged in as "admin"
    Then I have received the group creation request in my inbox

  Scenario: CE Participant does not complete all Group Creation Request mandatory fields
    Given Log in
      | CE Participant A |
    And Navigate to the relevant location to create a Group Creation Request
      | [In the create action menu] |
    Then the user is presented with a Group Creation Request form. The form 'Requestor' field is pre-populated with the current user's details
    And partially complete the group request form (omitting one or more mandatory fields), then submit the form
      | Each of these fields are mandatory, leave one or more empty |
      | Group Name													|
      | Group Description											|
      | Group Owner [Current User]  								|
    Then the system displays an appropriate notification to the user informing them that mandatory fields were not populated. The group request is not accepted/submitted
