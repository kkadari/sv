Feature: Getting started feature
#JUC39.1: Participant completes a step on their Getting Started Path
#JUC39.2: Participant dismisses Getting Started Path
#JUC39.3: Participant resumes Getting Started Path
#JUC39.4: First time visiting Participant is directed to Getting Started Path
#JUC39.5: Participant abandons part way through a step

  Scenario: Participant completes a step on their Getting Started Path
    Given I am on the Getting started progress page
    When I select one of the steps
    And I complete the step actions
    Then the step is marked as completed

  Scenario: Participant dismisses Getting Started Path
    Given I am on the Getting started progress page
    When I click on the dismiss getting started link
    Then I am redirected back to the home page
    And the getting started option is removed from the feeds list

  Scenario: Participant resumes Getting Started Path
    Given I have dismissed the Getting started progress page
    And I have navigate to the preferences page
    When I update my preferences to re-enable the getting started page
    Then I will see the getting started option re-enabled in the feeds list

  Scenario: First time visiting Participant is directed to Getting Started Path
    Given I have logged in as user who has never logged in before
    Then I will be directed to the getting started page

  Scenario: Participant abandons part way through a step
    Given I am on the Getting started progress page
    When I select one of the steps
    And I don't complete the step actions
    Then the step is not marked as completed
