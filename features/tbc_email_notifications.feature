Feature: Email notifications

  Scenario: Participant triggers a new blog post notification email
    Given 'participant B' is following 'participant A' blog
    When I create a new blog as 'participant A'
    Then 'participant B' will receive an email notification regarding a new blog post
    And the subject of the email will match the subject of the blog

  Scenario: Participant triggers a new blog post comment notification email
    Given 'participant B' is following 'participant A' blog
    When I add a new comment to one of my blogs as 'participant A'
    Then 'participant B' will receive an email notification regarding a new blog post comment
    And the subject of the email will match the subject of the blog

  Scenario: CE Participant receives e-mail notification for newly created content in a Group
    Given the following participants are member of a private group
     | participant A |
     | participant B |
    When I create a new piece of content in the private group as 'participant A'
    Then 'participant B' will receive an email notification regarding the new content for the private group
    And the email will conceal any reference to the author

  Scenario: CE Participant receives e-mail notification for newly commented on content in a Group
    Given the following participants are member of a private group
      | participant A |
      | participant B |
    When I add a new comment to a piece of content in the private group as 'participant A'
    Then 'participant B' will receive an email notification regarding the new content for the private group
    And the email will conceal any reference to the author
