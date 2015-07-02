Feature: [CISP-761] Participant lists Content, People, and Places using Thumbnail View
#<p>Test written to cover <a href="http://dev236:8080/browse/CISP-661" title="CLONE - Jive renders poorly at high resolution on windows 7 using chrome 32" class="issue-link" data-issue-key="CISP-661"><del>CISP-661</del></a></p>

  Scenario: Participant lists Content, People, and Places using Thumbnail View
	Given I log in
	  | User A: CE participant email and password |
	And I navigate to the Places page and select to view content in the Thumbnail View
	Then I am viewing the Places page and the content is displayed correctly in the Thumbnail View
	And I navigate to the People page and select to view content in the Thumbnail View
	Then I am viewing the People page and the content is displayed correctly in the Thumbnail View
	And I navigate to the Content page and select to view content in the Thumbnail View
	Then I am viewing the Content page and the content is displayed correctly in the Thumbnail View
