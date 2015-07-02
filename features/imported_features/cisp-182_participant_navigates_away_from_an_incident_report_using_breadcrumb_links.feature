Feature: [CISP-182] Participant navigates away from an incident report using breadcrumb links
#<p>Focus is on ensuring that the system property 'jive.breadcrumb.legacy' has been set to 'false' (in line with <a href="http://dev236:8080/browse/CISPS-98" title="Legacy breadcrumbs enabled on BT ref/live" class="issue-link" data-issue-key="CISPS-98"><del>CISPS-98</del></a>).</p>

  Scenario: Participant navigates away from an incident report using breadcrumb links
	Given I log in
	  | CE participant email and password |
	And I view an incident report
	  | Any incident report |
	Then I am viewing an incident report
	And I click the 'More incident reports' link in the breadcrumb trail
	And I am viewing the Content page for the related container, filtered by the content type.
