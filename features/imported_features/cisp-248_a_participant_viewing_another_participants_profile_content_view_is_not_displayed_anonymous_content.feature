Feature: [CISP-248] A Participant viewing another Participants Profile Content view is not displayed anonymous content
#<p>The focus of this test is to cover the following use case flow:</p>
#<ul class="alternate" type="square">
#	<li>JUC30-9 (TO BE CONFIRMED)</li>
#</ul>

  Scenario: A Participant viewing another Participants Profile Content view is not displayed anonymous content
	Given I log in (as User A)
	  | CE participant email and password |
	And I navigate to the relevant location to create an incident report
	Then I presented with a page for creating a new IR. The page is pre-populated with a default IHM level: Amber
	And I populate all the new incident report form fields, and change the IHM level
	  | THIS IS A TEST ANON INCIDENT REPORT- PLEASE DISREGARD | THIS IS A TEST INCIDENT REPORT BODY - PLEASE DISREGARD | Red | In a specific place: Testing (Group) |
	Then I have populated the incident report form fields
	And I select to post the incident report anonymously
	Then I have marked the incident report to be posted anonymously
	And I submit the incident report form
	Then the incident report form is submitted and the system will persist the new IR with a unique identifier, and with attribution to the Participant who created the IR
	And I log out (as User A)
	And I log in (as User B)
	  | CE participant email and password |
	And I navigate to the People view
	Then I am viewing the People view (which includes User A)
	And I select to view a CE participants profile
	  | User A (a CE participant) |
	Then I am viewing the Profile for a CE participant
	And I switch to the Content tab under the participants profile
	Then I am viewing the Content tab of the CE participant profile
	And I filter the content
	  |  [Try multiple variants of filters/view/list types]  |
	Then the filtered Content does not display Anonymous content attributed to the CE participant
