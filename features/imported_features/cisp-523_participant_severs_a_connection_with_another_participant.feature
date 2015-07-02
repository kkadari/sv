Feature: [CISP-523] Participant severs a connection with another Participant
#<p>This test covers use case realisation JUC2.3 - Participant severs a connection with another Participant</p>

  Scenario: Participant severs a connection with another Participant
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
	And I click the Follow button
	Then I have requested to form a connection with the user (User B).
	And I log out
	  | (as User A) |
	And I log in
	  | CE participant email and password (as User B) |
	And I navigate to Actions
	Then I have received a connection request (from User A)
	And I accept the connection request
	  | (from User A) |
	Then I have accepted the connection request.
	And I log out
	  | (as User B) |
	And if I log in
	  | CE participant email and password (as User A) |
	And I navigate to Actions
	Then I have received a notification that I have been added as [User B]'s connection
	And I navigate to People -> [User A] -> Connections and I filter on 'Following'
	Then [User B] is listed as a connection.
	When I click the 'Following in' button and click 'Stop Following'
	Then the connection is severed, and I am no longer following [User B]
