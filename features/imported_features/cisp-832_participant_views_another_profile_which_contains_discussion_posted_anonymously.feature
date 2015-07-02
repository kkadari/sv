Feature: [CISP-832] Participant views another Profile which contains Discussion posted Anonymously
#<p>The focus of this test is to cover the following use case realisation(s):</p>
#
#<ul class="alternate" type="square">
#	<li>JUC35.1: Participant views a Profile which contains content posted Anonymously</li>
#</ul>

  Scenario: Participant views another Profile which contains Discussion posted Anonymously
	Given I log in
	  | User A: CE participant email and password |
	And I navigate to the relevant location to create a discussion
	Then I presented with a page for creating a new Discussion. The page is pre-populated with a default IHM level: Amber
	And I populate all the new discussion form fields, and change the IHM level
	  | {Today's Date}-{Time}: Test Anon Discussion - Please disregard | {Today's Date}-{Time}: Test Anon Discussion - Please disregard | Amber | The CISP Community |
	Then I have populated the discussion form fields
	And I select to post the discussion anonymously
	Then I have marked the discussion to be posted anonymously
	And I submit the discussion form
	Then the discussion form is submitted and the system will persist the new discussion with a unique identifier, and with attribution to the Participant who created the discussion. An anonymous badge will be displayed,  indicating the discussion was posted anonymously.
	And I log in
	  | User B: CE participant email and password |
	And I discover a user of interest and click a link to their Profile Activity Stream
	  | {User A's profile} |
	Then the system will check that the Profile exists and is valid, and if so, displays the Profile Activity. However, content created Anonymously by the Profile owner {by User A in Step 6} is NOT shown.
