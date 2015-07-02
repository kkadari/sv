Feature: [CISP-358] Participant forms a relationship with another Participant
#<p>This test covers use case realisation JUC2.1 - Participant forms a relationship with another Participant</p>

  Scenario: Participant forms a relationship with another Participant
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
	Then I have requested to form a connection with the user
	And I log in
	  | CE participant email and password (as User B) |
	And I navigate to Actions
	Then I have received a connection request (from User A)
	And I accept the connection request
	  | (from User A) |
	Then I have accepted the connection request.
	And I navigate to People -> [User B] -> Connections and filter on 'Followers'
	Then [User A] is listed as a Follower.
	And if I log in
	  | CE participant email and password (as User A) |
	And I navigate to Activity
	Then the activity stream contains recent activity from the user that I am following
