Feature: [CISP-686] Participant resumes Getting Started Path
#<p>This test has been written to cover use case realisation:</p>
#
#<ul class="alternate" type="square">
#	<li>JUC39.3: Participant resumes Getting Started Path</li>
#</ul>

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
