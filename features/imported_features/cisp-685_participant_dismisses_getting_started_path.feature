Feature: [CISP-685] Participant dismisses Getting Started Path
#<p>This test has been written to cover use case realisation:</p>
#<ul class="alternate" type="square">
#	<li>JUC39.2: Participant dismisses Getting Started Path</li>
#</ul>

  Scenario: Participant dismisses Getting Started Path
	Given I log in
	  | [As User A] |
	Then I have logged in to the CE.
	And I navigate to my Getting Started Progress page.
	Then I have navigated to and am viewing a page showing my progress through the Getting Started path.
	When I click the link to dismiss the Getting Started path.
	Then the Getting Started page is dismissed and I am navigated back to my chosen Home screen.
