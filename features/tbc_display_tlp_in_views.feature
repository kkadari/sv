@ui
Feature: Displays Traffic light protocols in views

  Scenario: Spotlight search results contain Traffic light protocols pills
    Given I have logged in as "participant A"
    When I run a search for content in the Spotlight search
    Then all the spotlight results will have TLP pills that match their incident level

  Scenario: Advanced search results contain Traffic light protocols pills
    Given I have logged in as "participant A"
    When I run an advanced search for content in the Spotlight search
    Then all the results will have TLP pills that match their incident level

  Scenario: Activity stream entries contain Traffic light protocols pills
    Given I have logged in as "participant A"
    When I view an activity stream for recent content
    Then all the activity entries will have TLP pills that match their incident level

  Scenario: Browse content view contain Traffic light protocols pills
    Given I have logged in as "participant A"
    When I navigate to browse content
    Then all the content entries will have TLP pills that match their incident level