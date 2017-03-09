@manual
Feature: Email anonymity

  Scenario: Notifications aren't triggered if an event is marked as anonymous
    Given I am logged in as 'participant A'
    When I create a new <item> anonymously
    Then no email notification will be triggered
