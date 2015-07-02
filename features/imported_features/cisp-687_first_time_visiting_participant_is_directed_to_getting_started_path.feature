Feature: [CISP-687] First time visiting Participant is directed to Getting Started Path
#<p>This test has been written to cover use case realisation:</p>
#<ul class="alternate" type="square">
#	<li>JUC39.4: First time visiting Participant is directed to Getting Started Path</li>
#</ul>

  Scenario: First time visiting Participant is directed to Getting Started Path
	Given I log in and accept the T&Cs
	  | [As a brand new User A] |
	Then I have logged in to the CE, have accepted the T&Cs, and I am presented with the Getting Started Welcome Screen
	And I dismiss/close the Welcome Screen
	Then I have closed the Welcome Screen
	And I navigate to my Getting Started Progress page
	Then I have navigated to and am viewing a page showing my progress through the Getting Started path
