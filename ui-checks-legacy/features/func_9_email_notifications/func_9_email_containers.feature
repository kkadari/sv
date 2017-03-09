@manual
Feature: Email container handling

  Scenario Outline: Unencrypted notifications don't show the container
    Given the tlp email extension setting is set to <colour>
    And I have opted to receive unencrypted notifications
    When I create a amber blog post in a private group
    Then the members of the private group will be informed by email notification that the content has been created
    And the private group it was created for will be hidden

  Examples:
    | colour |
    | red    |
    | white  |

  Scenario Outline: Encrypted notifications show the container based on the TLP setting
    Given the tlp email extension setting is set to <colour>
    And I have opted to receive encrypted notifications
    When I create a amber blog post in a private group
    Then the members of the private group will be informed by email notification that the content has been created
    And the private group it was created for will be <outcome>

  Examples:
    | colour | outcome |
    | red    | hidden  |
    | white  | shown   |

  Scenario Outline: Only notifications related to group containers show a group
    Given the tlp email extension setting is set to red
    And I have opted to receive encrypted notifications
    When I create an amber incident report for <container>
    Then a notification email will be sent
    And the container it was created for will be <outcome>

  Examples:
    | container          | outcome |
    | the CiSP community | hidden  |
    | a private group    | shown   |
    | an individual      | hidden  |
