@manual
Feature: Email attribution

  Scenario Outline: Unencrypted notifications don't show the author
    Given the tlp email extension setting is set to <colour>
    And I have opted to receive unencrypted notifications
    When I create a amber blog post in a private group
    Then the members of the private group will be informed by email notification that the content has been created
    And the author attribution in the email will be hidden

    Examples:
      | colour |
      | red    |
      | white  |

  Scenario Outline: Encrypted notifications show the author based on the TLP setting
    Given the tlp email extension setting is set to <colour>
    And I have opted to receive encrypted notifications
    When I create a amber blog post in a private group
    Then the members of the private group will be informed by email notification that the content has been created
    And the author attribution in the email will be <outcome>

    Examples:
      | colour | outcome |
      | red    | hidden  |
      | white  | shown   |
