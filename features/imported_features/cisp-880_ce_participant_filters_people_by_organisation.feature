Feature: [CISP-880] CE Participant filters People by organisation
#<p>This test was written to cover use case JUC44.1: CE Participant filters People by organisation.</p>

  Scenario: CE Participant filters People by organisation
	Given I log in
	  | CE participant e-mail and password. |
	Then I am logged in to the CE
	When I navigate to People
	Then I am viewing a list of CE participants within the system.
	And I switch to the Details view
	Then I am viewing a list of CE participants in the Details view, and the following fields are displayed
	  | Person, Followers, Following, Latest Activity and Last Logged In |
	And I select the filter to view All people
	Then all CE participants are displayed
	And I add a filter to Filter by organisation
	Then I have added a filter to sort by organisation, and the list of organisations is sorted alphabetically
	And I select an organisation name
	  | Any |
	Then the results are updated to only show CE participants from that particular organisation
