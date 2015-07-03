Feature: Getting started feature
#<p>This test has been written to cover use case realisation:</p>
#<ul class="alternate" type="square">
#	<li>JUC39.1: Participant completes a step on their Getting Started Path</li>
#	<li>JUC39.2: Participant dismisses Getting Started Path</li>
#	<li>JUC39.3: Participant resumes Getting Started Path</li>
#	<li>JUC39.4: First time visiting Participant is directed to Getting Started Path</li>
#	<li>JUC39.5: Participant abandons part way through a step</li>
#</ul>

  Scenario: Participant completes a step on their Getting Started Path
    Given I log in
      | [As User A] |
    Then I have logged in to the CE
    And I navigate to my Getting Started Progress page
    Then I have navigated to and am viewing a page showing my progress through the Getting Started path
    When I select an incomplete step and follow it to completion
      | [Test all steps] |
    Then I have completed an incomplete step, and the system records that step as complete and indicates it is complete by a strikethrough on the getting started page. The % complete indicator on the 'Get Started' sidebar navigation menu also increases accordingly

  Scenario: Participant dismisses Getting Started Path
    Given I log in
      | [As User A] |
    Then I have logged in to the CE.
    And I navigate to my Getting Started Progress page.
    Then I have navigated to and am viewing a page showing my progress through the Getting Started path.
    When I click the link to dismiss the Getting Started path.
    Then the Getting Started page is dismissed and I am navigated back to my chosen Home screen.

  Scenario: Participant resumes Getting Started Path
    Given I log in
      | [As User A] |
    And I navigate to my Getting Started Progress page.
    Then I have navigated to and am viewing a page showing my progress through the Getting Started path.
    And I click the link to dismiss the Getting Started path.
    Then the Getting Started page is dismissed and I am navigated back to my chosen Home screen.
    And I navigate to my Preferences
    Then I am viewing my Preferences page.
    And I opt to to resume the Getting Started feature and submit changes to my preferences.
      | [Set Getting Started enabled to True] |
    Then the system indicates that I have successfully updated my Preferences.
    And I navigate to the Home page.
    Then I am viewing the Home page.
    And I navigate to my Getting Started Progress page
    Then I have navigated to and am viewing a page showing my progress through the Getting Started path.

  Scenario: First time visiting Participant is directed to Getting Started Path
    Given I log in and accept the T&Cs
      | [As a brand new User A] |
    Then I have logged in to the CE, have accepted the T&Cs, and I am presented with the Getting Started Welcome Screen
    And I dismiss/close the Welcome Screen
    Then I have closed the Welcome Screen
    And I navigate to my Getting Started Progress page
    Then I have navigated to and am viewing a page showing my progress through the Getting Started path

  Scenario: Participant abandons part way through a step
    Given I log in
      | [As User A] |
    Then I have logged in to the CE
    And I navigate to my Getting Started Progress page
    Then I have navigated to and am viewing a page showing my progress through the Getting Started path
    When I select an incomplete step and abandon it part-way through
      | [Variants: Check 'completion' triggers across all steps] |
    Then I have not completed an incomplete step, and the system does not record that step as complete, nor indicates it is complete by a strikethrough on the getting started page. The % complete indicator on the 'Get Started' sidebar navigation menu does not change as a result either

