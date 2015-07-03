Scenario: CE Participant updates their Professional Profile field
  Given I have logged in as "participant A"
  And Navigate to 'Edit Profile' from the Jive menu, then switch to the 'Your Profile' tab
  Then The Professional Profile field is visible
  And Populate the Professional Profile field
    | Variants										    |
    | 1) Try Input >3500 chars, save, check validation. |
    | 2) Input <= 3500 chars, save. 					|
  Then Professional Profile stored successfully.
  And Navigate to 'Edit Profile' from the Jive menu, then switch to the 'Privacy' tab.
  Then By default, the Professional Profile field is set as visible to 'Registered Users'
  And Log out of the CE
  Then Logged out of the CE
  And Log in to the CE
    | [As CE Participant B] |
  Then Logged in to the CE
  And Navigate to 'People', then filter on a specific CE participant
    | [CE Participant A] |
  Then List of people filtered successfully.
  And Click to view a specific CE participant within the People list
    | [CE Participant A] |
  Then The system presents the user's Profile page. The 'Professional Profile' field is displayed and populated for the user