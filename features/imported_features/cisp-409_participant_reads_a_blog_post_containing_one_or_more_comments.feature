Feature: [CISP-409] Participant reads a blog post containing one or more comments
#<p>This test was written to cover use case realisation(s):</p>
#
#<p>JUC37.1 - Participant reads a Blog Post<br/>
#JUC30.2 - Participant creates a new Blog Post with non-default IHM </p>

  Scenario: Participant reads a blog post containing one or more comments
	Given I log in
	  | CE participant email and password |
	When I select the option to create a new Blog Post within the CE
	Then I am presented with a form to enter the necessary information to create a new blog post
	And I complete the necessary form fields to create a new blog post
	Then I have filled out the form to create a new blog post
	And I submit the form for creating a new blog post
	Then the system acknowledges that the blog post was successfully submitted, and I am navigated to a page where I can view the newly created blog post
	And I navigate to add a new comment to the blog post
	  | THIS IS A NEW COMMENT - PLEASE DISREGARD. |
	Then the comment is posted to the blog post.
