Feature: [CISP-688] Participant abandons part way through a step
#<p>This test has been written to cover use case realisation:</p>
#<ul class="alternate" type="square">
#	<li>JUC39.5: Participant abandons part way through a step</li>
#</ul>

  Scenario: Participant abandons part way through a step
	Given I log in
	  | [As User A] |
	Then I have logged in to the CE
	And I navigate to my Getting Started Progress page
	Then I have navigated to and am viewing a page showing my progress through the Getting Started path
	When I select an incomplete step and abandon it part-way through
	  | [Variants: Check 'completion' triggers across all steps] |
	Then I have not completed an incomplete step, and the system does not record that step as complete, nor indicates it is complete by a strikethrough on the getting started page. The % complete indicator on the 'Get Started' sidebar navigation menu does not change as a result either
