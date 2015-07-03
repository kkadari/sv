Feature: [CISP-856] Validate HTML Markup
#<p>This test relates to the validation of HTML markup, specifically within the various pages/forms of the F5/2FA login pages of the CE.</p>

  Scenario: Validate HTML Markup
	Given Given I have extracted the HTML source of a webpage of interest
	  | Variants 						  |
	  | F5 login form (e-mail / password) |
	  | F5 2fa token form                 |
	  | F5 password reset form            |
	  | F5 password reset failure / form  |
	Then I have extracted the HTML source of a webpage
	And I validate the markup for the HTML source using a the W3C validation service
	  | [http://validator.w3.org/check] |
	Then the markup is valid and returns no errors
