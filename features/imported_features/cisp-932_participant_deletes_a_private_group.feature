Feature: [CISP-932] Participant deletes a private group
#<p>The focus of this test is to cover the following use case realisation:</p>
#<ul class="alternate" type="square">
#	<li>JUC5.2: Admin creates a group</li>
#</ul>

  Scenario: Participant deletes a private group
	Given I log in
	  | [As User A - a CE participant] |
	And I search for the name of a group I created
	  |  [via Spotlight Search)  |
	Then I am displayed a list of matching search results, including the Group I created
	And I submit the search form
	Then I am taken to the Jive Search page, and the system returns matching search results for my term
	And I change the default search option to Search Places
	Then the Jive Search is updated to Search within Places rather than Content (default)
	And I click on the matching search result
	Then the system navigates to the default view for my Private Group
	And I select Manage -> Delete
	  | [Within the Private Group that I am an author of] |
	Then I am presented with a confirmation dialogue asking me if I am sure I want to delete the group
	And I confirm that I wish to delete the group
	Then the Private Group is deleted, and all content created within that group no longer exists within the system
