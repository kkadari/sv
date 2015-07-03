@JUC30
Feature: JUC30 - Create a blog post
#<li>JUC30-9 (TO BE CONFIRMED)</li>
#<p>JUC37.1 - Participant reads a Blog Post<br/>
#JUC30.2 - Participant creates a new Blog Post with non-default IHM </p>

  @JUC30.1 @CISP-603
  Scenario: Participant creates an amber blog post in their personal blog
    Given I have logged in as "participant A" 
    And I have created an amber blog post in my personal blog
    When I have logged in as "participant B"
    Then I can locate and view the blog post

  @JUC30.3 @CISP-604
  Scenario: Participant creates a green blog post in a private group
    Given I have logged in as "participant A" 
    And I have created a green blog post in a private group
    When I have logged in as "participant B"
    Then I can locate and view the blog post
        
  @JUC30.3 @CISP-930
  Scenario: Participant creates an amber blog post in a private group
    Given I have logged in as "participant A"
    And I have created an amber blog post in a private group
    When I have logged in as "participant B"
    Then I can locate and view the blog post

  Scenario: A Participant viewing another Participants Profile Content view is not displayed anonymous content
    Given I log in (as User A)
      | CE participant email and password |
    And I navigate to the relevant location to create an incident report
    Then I presented with a page for creating a new IR. The page is pre-populated with a default IHM level: Amber
    And I populate all the new incident report form fields, and change the IHM level
      | THIS IS A TEST ANON INCIDENT REPORT- PLEASE DISREGARD | THIS IS A TEST INCIDENT REPORT BODY - PLEASE DISREGARD | Red | In a specific place: Testing (Group) |
    Then I have populated the incident report form fields
    And I select to post the incident report anonymously
    Then I have marked the incident report to be posted anonymously
    And I submit the incident report form
    Then the incident report form is submitted and the system will persist the new IR with a unique identifier, and with attribution to the Participant who created the IR
    And I log out (as User A)
    And I log in (as User B)
      | CE participant email and password |
    And I navigate to the People view
    Then I am viewing the People view (which includes User A)
    And I select to view a CE participants profile
      | User A (a CE participant) |
    Then I am viewing the Profile for a CE participant
    And I switch to the Content tab under the participants profile
    Then I am viewing the Content tab of the CE participant profile
    And I filter the content
      |  [Try multiple variants of filters/view/list types]  |
    Then the filtered Content does not display Anonymous content attributed to the CE participant

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
