Feature: [CISP-1007] CE Participant does not complete all Group Creation Request mandatory fields
#<p>The focus of this test is to cover the following use case realisation: </p>
#<ul class="alternate" type="square">
#	<li>JUC42.2: CE Participant does not complete all Group Creation Request mandatory fields</li>
#</ul>
#<p>For more information, see: <a href="http://xwiki.sure.vine/xwiki/bin/view/CERT-UK/JUC42+Submit+Group+Creation+Request" class="external-link" rel="nofollow">http://xwiki.sure.vine/xwiki/bin/view/CERT-UK/JUC42+Submit+Group+Creation+Request</a></p>

  Scenario: CE Participant does not complete all Group Creation Request mandatory fields
	Given Log in
	  | CE Participant A |
	And Navigate to the relevant location to create a Group Creation Request
	  | [In the create action menu] |
	Then the user is presented with a Group Creation Request form. The form 'Requestor' field is pre-populated with the current user's details
	And partially complete the group request form (omitting one or more mandatory fields), then submit the form
	  | Each of these fields are mandatory, leave one or more empty |
	  | Group Name													|
	  | Group Description											|
	  | Group Owner [Current User]  								|
	Then the system displays an appropriate notification to the user informing them that mandatory fields were not populated. The group request is not accepted/submitted