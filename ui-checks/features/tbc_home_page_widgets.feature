Feature: Home page widgets

  @ui
  Scenario: Hero banner widget
    Given I have logged in as "participant A"
    Then I am displayed a banner containing an image, text and a link to a page

  @manual
  Scenario: Editing the Hero banner widget
    Given I have logged in as "admin"
    And I've navigated to the slideshow config page
    When I enter a new entry containing an image, text and a link into the slideshow table
    And I navigate back to the homepage
    Then I will see my new entry in the banner

  @ui @tv
  Scenario: Static call to action widgets
    Given I have logged in as "participant A"
    Then I will see three call to action widgets
    And a sidebar widget containing links under the titles Get Involved and How we can help

  @ui
  Scenario: Whats happening widget loads
    Given I have logged in as "participant A"
    Then I will see the What's happening widget
    And it is defaulted to the 'All' view
    And each of the entries contain a title, author and TLP pill

  @ui
  Scenario: What's happening - Popular tab
    Given I have logged in as "participant A"
    When I click on the "Popular" tab in the What's happening widget
    Then I am presented with content from the people I am following

  @ui
  Scenario: What's happening - Following tab
    Given I have logged in as "participant A"
    When I click on the "Following" tab in the What's happening widget
    Then I am presented with content from the people I am following
