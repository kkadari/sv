Feature: [CISP-607] Participant is following a Group in an Activity Stream which has content posted anonymously
#<p>The focus of this test is to cover the following use case realisation(s):</p>
#<ul class="alternate" type="square">
#	<li>JUC27.3: Participant is following a Group in an Activity Stream which has content posted anonymously</li>
#</ul>
#<p>Please note: This test requires two users' interaction within the CE (User A, User B), where User A &amp; User B are members of the same Group.</p>

  Scenario: Participant is following a Group in an Activity Stream which has content posted anonymously
	Given I log in
	  | User A: CE participant email and password |
	And I navigate to a group that I am a member of
	  | (Both User A and B must be a member of the same group). |
	Then I am viewing the group that I am a member of
	And I select to follow the group activity in my Connections Stream
	Then I have selected to Follow the group in my Connections Stream
	And I log in
	  | User B: CE participant email and password |
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
	And I log in
	  | User A: CE participant email and password |
	When I navigate to my Connections Stream
	Then I am viewing my Connections Stream and the system presents the latest content from the stream. Specifically, the system presents the recent post made (by User B) but the anonymity of the Author is respected, and not displayed
