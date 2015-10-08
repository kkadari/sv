@manual
Feature: Email notifications

  Scenario Outline: Notification triggered when a user creates a new piece of content
    Given I have created a new <content_type> for a private group
    Then the members of the private group will be informed by email notification that the content has been created

    Examples:
      | content_type    |
      | blog post       |
      | incident report |
      | discussion      |
      | poll            |
      | uploaded file   |

  Scenario Outline: Notification triggered when a user comments on a piece of content
    Given I have created a new <content_type> for a private group
    When I have leave a comment on the new content
    Then the members of the private group will be informed by email notification that a new comment has been created

    Examples:
      | content_type    |
      | blog post       |
      | incident report |
      | discussion      |
      | poll            |
      | uploaded file   |

  Scenario: Notification triggered when a user sends a direct message to another user
    Given I have created a message for "participant A"
    Then "participant A" will be informed by email notification that they have a new message

  Scenario Outline: Notification triggered when a user moves a piece of content to a new container
    Given I have created a new <content_type> for a private group
    When I move the new content type to a new private group
    And I opt to announce this move on all feeds
    Then the members of the private group will be informed by email notification that the content has been moved to a new group

    Examples:
      | content_type    |
      | blog post       |
      | discussion      |
      | poll            |
      | uploaded file   |


  Scenario: Notification triggered when a user requests approval of an uploaded document
    Given I have logged in as "participant A"
    When I have created an uploaded document that requires approval from "participant B"
    Then "participant B" will be informed by email notification that a document requires approval

  Scenario: Notification triggered when a user moderates approval of an uploaded document
    Given I have logged in as "participant A"
    And I have requested "participant B" approve an uploaded document I have created
    When "participant B" <actions> the uploaded document
    Then I am informed by email notification that my uploaded document has been <outcome>

    Examples:
      | actions  | outcome  |
      | approves | accepted |
      | reject   | rejected |

  Scenario: Notification triggered when a user requests to follow another user
    Given I have logged in as "participant A"
    And I have requested "participant B" approve an uploaded document I have created
    When "participant B" rejects the uploaded document
    Then I am informed by email notification that my uploaded document has been rejected

  Scenario Outline: Notification triggered when a user moderates a follow request from another user
    Given I have logged in as "participant A"
    And I have requested to follow "participant B"
    When "participant B" <actions> the follow request
    Then I am informed by email notification the my uploaded document has been <outcome>

    Examples:
      | actions  | outcome  |
      | approves | accepted |
      | reject   | rejected |

  Scenario: Notification triggered when a user mentions another user
    Given I have logged in as "participant A"
    When I mention "participant B" in a comment
    Then "participant B" is informed by email notification that they have been mentioned

  Scenario Outline: Notification triggered when a user marks a document for action
    Given I have created a new uploaded document for a private group
    When I mark the the document as <action>
    Then the members of the private group will be informed by email notification that the content has been marked as <action>

    Examples:
      | action            |
      | final             |
      | success           |
      | outdated          |
      | marked for action |

  Scenario: Notification triggered when a user invites another user to a group
    Given I have logged in as "admin"
    When I invite "participant A" to join a private group
    Then "participant A" will be informed by email notification that they are invited to join a group

  Scenario: Notification triggered when a user requests to join a group
    Given I have logged in as "participant A"
    When I request to join a private group
    Then the administrator of the group will be informed by email notification that a user has requested to join the private group

  Scenario Outline: Notification triggered when a user moderates another users request to join a group
    Given I have logged in as "participant A"
    And I have requested to join a private group
    When I <action> the request to join the private group as "admin"
    Then "participant A" will be informed by email notification that their request to join the private group has been <outcome>

    Examples:
      | action   | outcome  |
      | approves | accepted |
      | reject   | rejected |

  Scenario: Notification triggered when a user endorses another user with a new skill
    Given I have logged in as "participant A"
    When I endorse "participant B" for a new skill
    Then "participant B" will be informed by email notification that they have been endorsed for a new skill

  Scenario: Notification triggered when an announcement is created
    Given I have logged in as "admin"
    When I create a new system announcement
    Then all members of CiSP will be informed by email notification of a new system announcement

  Scenario: Notification triggered when a piece of content is marked as abuse
    Given I have logged in as "participant A"
    When I mark a piece of content as abuse
    Then "admin" will be informed by email notification that a piece of content has been marked as abuse
