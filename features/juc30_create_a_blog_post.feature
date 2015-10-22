@JUC30
Feature: JUC30 - Create a blog post
#JUC37.1 - Participant reads a Blog Post
#JUC30.2 - Participant creates a new Blog Post with non-default IHM

  @JUC30.1
  Scenario: Participant creates an amber blog post in their personal blog
    Given I have logged in as "participant A"
    And I have created an amber blog post in my personal blog
    When I have logged in as "participant B"
    Then I can locate and view the blog post

  @JUC30.3
  Scenario: Participant creates a green blog post in a private group
    Given I have logged in as "participant A"
    And I have created a green blog post in a private group
    When I have logged in as "participant B"
    Then I can locate and view the blog post

  @JUC30.3
  Scenario: Participant creates an amber blog post in a private group
    Given I have logged in as "participant A"
    And I have created an amber blog post in a private group
    When I have logged in as "participant B"
    Then I can locate and view the blog post

  Scenario: Participant reads a blog post containing one or more comments
    Given I have logged in as "participant A"
    And I have created an amber blog post in a private group
    When I submit a comment for the blog post
    Then the comment is posted to the blog post
