Feature: [CISP-874] Valid CE users cannot be identified by enumerating email addresses at Login
#<p>Test created to confirm response from invalid email/password combination cannot be used as a means to enumerate email addresses to identify CE users. See: <a href="http://dev236:8080/browse/CISP-870" title="Login allows enumeration" class="issue-link" data-issue-key="CISP-870"><del>CISP-870</del></a>.</p>

	Scenario: Valid CE users cannot be identified by enumerating email addresses at Login
	  Given I have configured BurpSuite Pro to act as a proxy to capture HTTP requests/responses
	  Then BurpSuite is actively capturing request/response data
	  And I visit the CE login page
	  Then I am viewing the CE login page
	  And I enumerate through various existing and non-existing CE e-mail addresses whilst submitting the login form
		| tim.durden@surevine.com        |
		| tim.durden@unknown-company.abc |
	  Then the login is unsuccessful, and the system redirects the user to the same form, with an appropriate error message
	  And I have captured the returned response (unsuccessful login page) from the login form between an existing CE user's e-mail address, and an invalid e-mail address
	  Then I have data that can be compared to determine if the responses are suitably different to identify a valid e-mail address from an invalid one
	  And I use the BurpSuite Pro comparator tool to compare the responses from both a valid and invalid e-mail address
	  Then there is no specific difference between the failed login response attempted with a valid e-mail address from that of an e-mail address that does not belong to a CE user
