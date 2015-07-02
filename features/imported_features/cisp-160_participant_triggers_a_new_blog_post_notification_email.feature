Feature: [CISP-160] Participant triggers a new blog post notification email

  Scenario: Participant triggers a new blog post notification email
	Given I log in
		| CE participant email and password |
	And another CE participant is following my personal blog
		| Email notifications have been enabled for the stream the user is following the personal blog in. |
	When I select the option to create a new blog post within the CE
	Then I am displayed the form for creating a new blog post within the CE.
	And I populate and submit the new blog post
	Then the system acknowledges that the Blog Post was successfully submitted, and the system displays the newly created blog post.
	And the CE participant following my personal blog receives an e-mail notification.
	Then the e-mail notification subject line reads "Blog Post - THIS IS A TEST BLOG POST - PLEASE DISREGARD"
