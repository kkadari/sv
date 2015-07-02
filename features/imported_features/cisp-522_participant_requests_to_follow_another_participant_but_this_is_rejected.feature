Feature: [CISP-522] Participant requests to follow another Participant but this is rejected
#<p>This test covers use case realisation JUC2.2 - Participant requests to follow another Participant but this is rejected.</p>

  Scenario: Participant requests to follow another Participant but this is rejected
    Given I log in
      | CE participant email and password (as User A) |
    And I navigate to People
    Then I am viewing the People list
    And I filter on a specific CE participant
      | (User B) |
    Then I have filtered the list of CE participants to the user I am interested in
    And I select to view a specific CE participant within the People list
      | (User B) |
    Then I am displayed the Bio tab within the profile of the CE participant
    When I click the Follow button
    Then I have requested to form a connection with the user.
    And I log in
      | CE participant email and password (as User B) |
    And I navigate to Actions
    Then I have received a connection request (from User A)
    And I reject the connection request
      | (from User A) |
    Then I have rejected the connection request.
    Then if I log in
      | CE participant email and password (as User A) |
    And I navigate to Actions
    Then I have received a notification that I have not been added as [user B's] connection.
    And I navigate to People -> [User A] -> Connections
    Then [User B] is not listed as a connection.
    And I log out
      | (as User A) |
