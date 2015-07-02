Feature: [CISP-999] CE Participant submits Group Creation Request form successfully
#<p>The focus of this test is to cover the following use case realisation: </p>
#<ul class="alternate" type="square">
#	<li>JUC42.1: CE Participant submits Group Creation Request form successfully.</li>
#</ul>
#<p>For more information, please see: <a href="http://xwiki.sure.vine/xwiki/bin/view/CERT-UK/JUC42+Submit+Group+Creation+Request" class="external-link" rel="nofollow">http://xwiki.sure.vine/xwiki/bin/view/CERT-UK/JUC42+Submit+Group+Creation+Request</a></p>

  Scenario: CE Participant submits Group Creation Request form successfully
	Given I log in
	  | CE Participant A: email and password |
	And And I navigate to the relevant location to create a Group Creation Request
	|  [In the create action menu]  |
	Then I presented with a form for creating a new Group Creation Request
	And the form 'Requestor' field is pre-populated with the current user's details
	And I complete and submit the form with all the necessary fields populated for the group
	  | Group Name 																|
	  | Group Description	         											|
	  | Group Owner [Current User]            									|
	  | Additional Group Owner [CE Participant B]      							|
	  | Group Supporters [CE Participant C, D & E]								|
	  | Content Types [Blogs, Documents, Discussions, Polls, Incident Reports]  |
	Then I have filled out the necessary fields for the group and submitted the form successfully
	And I submit the Group Request form
	Then the system notifies all of the CE Participants mentioned on the application (including the requestor). The system also notifies all relevant Facilitators (Support Users / Admins)
	And I navigate to my inbox
	Then I have received a Notification that indicates I have requested the group is created
	And I log in as CE Participant B and navigate to my Inbox
	Then I have received a Notification that indicates I have been added as an additional owner for the group request
	And I log in as CE Participant C and navigate to my inbox
	Then I have received a Notification that indicates I have been added as a Group Supporter for the group request
	And I log in as CE Participant D and navigate to my inbox
	Then I have received a Notification that indicates I have been added as a Group Supporter for the group request
	And I log in as CE Participant E and navigate to my inbox
	Then I have received a Notification that indicates I have been added as a Group Supporter for the group request
