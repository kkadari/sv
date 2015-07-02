Feature: [CISP-380] Admin creates a new private group
#<p>The focus of this test is to cover the following use case realisation:</p>
#<ul class="alternate" type="square">
#	<li>JUC5.2: Admin creates a group</li>
#</ul>

Scenario: Admin creates a new private group
	Given I log in
	  | Admin email and password |
	And I select to create a new group
      | [via menu bar] |
	Then I am displayed a form to create a new group
	And I enter basic group information
      """ Group Name:
      TEST - Private Group - PLEASE DISREGARD

      Group Description: This is a private group for testing. Please disregard."""
	Then I have filled out basic information for creating a new group
	And I expand the Advanced options for the group creation form
	Then I am displayed advanced options on the group creation form
	And I set the Group Type to Private
	Then I have selected to create a Private group type
	And I select to include all necessary Group Features
	  | [Blogs, Discussions, Polls, Incident Reports] |
	Then I have selected to include all necessary Group Features
	And I submit the group creation form
	Then I have submitted the group creation form, my group is created with all the data submitted in the form, and I am displayed the Group Overview page for the group that I have created


