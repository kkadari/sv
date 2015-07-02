Feature: [CISP-612] Admin views a Profile which contains content posted Anonymously
#<p>The focus of this test is to cover the following use case realisation(s):</p>
#<ul class="alternate" type="square">
#	<li>JUC35.3: Admin views a Profile which contains content posted Anonymously</li>
#</ul>

  Scenario: Admin views a Profile which contains content posted Anonymously
	Given I log in
	 | User A: CE participant email and password |
	And I navigate to a group that I am a member of
	Then I am viewing the group that I am a member of
	And I navigate to the relevant location to create an incident report within the group
	Then I presented with a page for creating a new IR. The page is pre-populated with a default IHM level: Amber
	And I populate all the new incident report form fields, and change the IHM level
	  | {Today's Date}-{Time}: Test Anon IR - Please disregard | {Today's Date}-{Time}: Test Anon IR - Please disregard | Amber | In a specific place: {Group users are members of} |
	Then I have populated the incident report form fields
	And I select to post the incident report anonymously
	Then I have marked the incident report to be posted anonymously
	And I submit the incident report form
	Then the incident report form is submitted and the system will persist the new IR with a unique identifier, and with attribution to the Participant who created the IR. An anonymous badge will be displayed, indicating the IR was posted anonymously.
	And I log in
	  | {As Admin} |
	When I discover a user of interest and click a link to their Profile
	  | {User A's profile} |
	Then the system will check that the Profile exists and is valid, and if so, displays the Profile
	And I navigate to the user's Content tab
	  | {User A's profile -> Content} |
	Then content created Anonymously {as per User A; step 6} is displayed in the Profile alongside Attributed content
