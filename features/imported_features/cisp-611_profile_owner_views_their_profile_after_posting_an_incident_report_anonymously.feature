Feature: [CISP-611] Profile owner views their Profile after posting an Incident Report anonymously
#<p>The focus of this test is to cover the following use case realisation(s):</p>
#<ul class="alternate" type="square">
#	<li>JUC35.2: Profile owner views their Profile which contains content posted Anonymously</li>
#</ul>

  Scenario: Profile owner views their Profile after posting an Incident Report anonymously
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
	Then the incident report form is submitted and the system will persist the new IR with a unique identifier, and with attribution to the Participant who created the IR. An anonymous badge will be displayed, indicating the IR was posted anonymously
	When I click a link to my Profile
	  | {User A's profile} |
	Then the system will check that the Profile exists and is valid, and if so, displays the Profile. Content created Anonymously IS NOT (as of CE v1.10) displayed in the Profile
