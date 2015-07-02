Feature: [CISP-167] Participant triggers a new blog post comment notification email

  Scenario: Participant triggers a new blog post comment notification email
	Given I log in
	  | CE participant email and password |
	And another CE participant is following my personal blog
	  | Email notifications have been enabled for the stream the user is following the personal blog in. |
	And I create a new blog post
	Then the blog post is created
	And the CE participant following my personal blog receives an e-mail notification.
	Then the e-mail notification subject line reads "Blog Post - THIS IS A TEST BLOG POST - PLEASE DISREGARD"
	And I add a comment to the blog post
	  |  THIS IS A NEW COMMENT - PLEASE DISREGARD.  |
	Then the comment is added
	And the CE participant following my personal blog receives another e-mail notification.
	Then the e-mail notification subject line reads "Blog Post - THIS IS A TEST BLOG POST - PLEASE DISREGARD"
