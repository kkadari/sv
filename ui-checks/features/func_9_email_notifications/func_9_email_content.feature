@manual
Feature: Sample content in email

  Scenario Outline: Notifications show sample content based on the TLP setting
    Given the tlp email extension setting is set to <colour>
    When I create a amber blog post in a private group
    Then the members of the private group will be informed by email notification that the content has been created
    And the private group it was created for will be <outcome>

  Examples:
    | colour | outcome |
    | red    | shown   |
    | white  | hidden  |
