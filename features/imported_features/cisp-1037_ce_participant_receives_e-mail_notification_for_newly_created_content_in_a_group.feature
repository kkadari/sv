Feature: [CISP-1037] CE Participant receives e-mail notification for newly created content in a Group

Scenario: CE Participant receives e-mail notification for newly created content in a Group
  Given I log in
    | CE participant email and password |
  And another CE participant is following a group I am a member of
    | Email notifications have been enabled for the stream the user is following the group in. |
  And I select the option to create a content type within the CE
    | [Variants: ALL CONTENT TYPES] |
  Then I am displayed the appropriate form for creating the new content type within the CE
  And I populate and submit the content type
    | [Populate all mandatory fields, with recognisable data] |
  Then the system acknowledges that the content type was created successfully, and the system displays the newly created content type
  And the CE participant following the group receives an e-mail notification
  Then the e-mail notification From address does not show the author of the content, nor does the e-mail notification contain any information relating to the content author (including the URL to the content)
