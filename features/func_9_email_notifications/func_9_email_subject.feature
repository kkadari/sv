Feature: Email subject

  Scenario Outline: Notification shows title regardless of TLP setting
    Given the tlp email extension setting is set to <colour>
    When I have create a new blog post for a private group
    Then the members of the private group will be informed by email notification that the content has been created
    And they will be able to view the title of blog post

    Examples:
      | colour |
      | red    |
      | white  |