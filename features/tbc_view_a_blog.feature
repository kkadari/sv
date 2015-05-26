Feature: TBC view a blog

  @sit
  Scenario: Participant can read a blog post
    Given I have logged in as "participant A"
    When I find and click on a blog post I would like to read
    Then I can view the blog post