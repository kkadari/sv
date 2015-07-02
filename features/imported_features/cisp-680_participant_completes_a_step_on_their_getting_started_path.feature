Feature: [CISP-680] Participant completes a step on their Getting Started Path
#<p>This test has been written to cover use case realisation:</p>
#<ul class="alternate" type="square">
#	<li>JUC39.1: Participant completes a step on their Getting Started Path</li>
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
