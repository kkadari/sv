Feature: [CISP-184] Participant navigates away from a discussion using breadcrumb links
#<p>Focus is on ensuring that the system property 'jive.breadcrumb.legacy' has been set to 'false' (in line with <a href="http://dev236:8080/browse/CISPS-98" title="Legacy breadcrumbs enabled on BT ref/live" class="issue-link" data-issue-key="CISPS-98"><del>CISPS-98</del></a>).</p>

  Scenario: Participant navigates away from a discussion using breadcrumb links
	Given I log in
	  | CE participant email and password |
	And I view a discussion
	  | Any discussion that has not been published anonymously. |
	Then I am viewing a discussion
	And I click the 'More discussions' link in the breadcrumb trail
	And I am viewing the Content page for the related container, filtered by the content type.
	And I view an anonymous discussion
	  | Any discussion that has been published anonymously to the communit space. |
	Then I am viewing a discussion, and there is no breadcrumb trail displayed.
