@JUC35
Feature: JUC35 - View a profile

  @sit
  Scenario: User attempts to view the profile of an existing user
    Given I have logged in as "participant A"
    When I attempt to view the profile of an existing user
    Then I am shown that users profile details

  @JUC35.1
  Scenario: A Participant viewing another participant's profile is not shown anonymous content
    Given I have logged in as "participant A"
    And I have raised a white incident report anonymously in a private group
    Then participants are not able to view the incident report on the posters profile

  @JUC35.3
  Scenario: Admin views the profile of an anonymous content poster
    Given I have logged in as "participant A"
    And I have raised a white incident report anonymously in a private group
    When I have logged in as "admin"
    Then I as admin can verify the anonymous identifiers have been added in their profile

  @JUC35.4
  Scenario: User attempts to view the profile of a non existent user
    Given I have logged in as "participant A"
    When I attempt to view the profile of a non existent user
    Then I am notified that the user does not exist

  Scenario: Participant views the profile of an anonymous discussion poster
    Given I have logged in as "participant A"
    And I have created an amber discussion anonymously in the community
    When I have logged in as "participant B"
    Then participants are not able to view the discussion in the posters activity stream

  Scenario: Participant views their own profile after posting an anonymous discussion
    Given I have logged in as "participant A"
    And I have created an amber discussion anonymously in the community
    When I have logged in as "participant B"
    Then I am not able to view the discussion in my activity stream
