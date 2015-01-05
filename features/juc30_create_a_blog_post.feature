@JUC30
Feature: JUC30 - Create a blog post
  
  @JUC30.1 @CISP-603
  Scenario: Participant creates an amber blog post in their personal blog
    Given I have logged in as "participant A" 
    And I have created an amber blog post in my personal blog
    When I have logged in as "participant B"
    Then I can view the blog post

  @JUC30.3 @CISP-604
  Scenario: Participant creates a green blog post in a private group
    Given I have logged in as "participant A" 
    And I have created a green blog post in a private group
    When I have logged in as "participant B"
    Then I can view the blog post
        
  @JUC30.3 @CISP-930
  Scenario: Participant creates an amber blog post in a private group
    Given I have logged in as "participant A"
    And I have created an amber blog post in a private group
    When I have logged in as "participant B"
    Then I can view the blog post