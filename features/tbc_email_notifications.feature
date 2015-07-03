Feature: Email notifications

  Scenario: Participant triggers a new blog post notification email
    Given I log in
      | CE participant email and password |
    And another CE participant is following my personal blog
      | Email notifications have been enabled for the stream the user is following the personal blog in. |
    When I select the option to create a new blog post within the CE
    Then I am displayed the form for creating a new blog post within the CE.
    And I populate and submit the new blog post
    Then the system acknowledges that the Blog Post was successfully submitted, and the system displays the newly created blog post.
    And the CE participant following my personal blog receives an e-mail notification.
    Then the e-mail notification subject line reads "Blog Post - THIS IS A TEST BLOG POST - PLEASE DISREGARD"

  Scenario: Participant triggers a new blog post comment notification email
    Given I log in
      | CE participant email and password |
    And another CE participant is following my personal blog
      | Email notifications have been enabled for the stream the user is following the personal blog in. |
    And I create a new blog post
    Then the blog post is created
    And the CE participant following my personal blog receives an e-mail notification.
    Then the e-mail notification subject line reads "Blog Post - THIS IS A TEST BLOG POST - PLEASE DISREGARD"
    And I add a comment to the blog post
      |  THIS IS A NEW COMMENT - PLEASE DISREGARD.  |
    Then the comment is added
    And the CE participant following my personal blog receives another e-mail notification.
    Then the e-mail notification subject line reads "Blog Post - THIS IS A TEST BLOG POST - PLEASE DISREGARD"

  Scenario: CE Participant receives e-mail notification for newly created content in a Group
    Given I log in
      | CE participant email and password |
    And another CE participant is following a group I am a member of
      | Email notifications have been enabled for the stream the user is following the group in. |
    And I select the option to create a content type within the CE
      | [Variants: ALL CONTENT TYPES] |
    Then I am displayed the appropriate form for creating the new content type within the CE
    And I populate and submit the content type
      | [Populate all mandatory fields, with recognisable data] |
    Then the system acknowledges that the content type was created successfully, and the system displays the newly created content type
    And the CE participant following the group receives an e-mail notification
    Then the e-mail notification From address does not show the author of the content, nor does the e-mail notification contain any information relating to the content author (including the URL to the content)

  Scenario: CE Participant receives e-mail notification for newly commented on content in a Group
    Given I log in
      | CE participant email and password |
    And another CE participant is following a group I am a member of
      | Email notifications have been enabled for the stream the user is following the group in. |
    And I select the option to comment, review, or reply to existing content within the CE
      | Variants										 |
      | ALL CONTENT TYPES that support comments/replies. |
      | CHECK ANONYMOUS submissions too.                 |
    Then I am displayed the appropriate form for commenting, reviewing or reply to the content type within the CE
    And I populate and submit the comment/review/reply form
      | [Populate with recognisable data] |
    Then the system acknowledges and displays the newly submitted comment/review/reply
    And the CE participant following the group receives an e-mail notification that a comment/reply/review was made on the relevant content type.
    Then the e-mail notification From address does not show the author of the comment/review/reply, nor does the e-mail notification contain any information relating to the content author (including the URL to the content)
