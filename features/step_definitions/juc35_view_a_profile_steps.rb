Then /^I as admin can verify the anonymous identifiers have been added in their profile$/ do
  on(HomePage).click_people
  on(PeoplePage).search_for_user(FigNewton.user1_surname)
  on(PeoplePage).click_result(FigNewton.user1_irlname)
  on(UserOneProfilePage).click_content
  # Check content is there and anon
end

Then /^participants are not able to view the incident report on the posters profile$/ do
  visit(LoginPage).log_in username = FigNewton.user2_uname, password = FigNewton.user2_pswd
  on(HomePage).click_people
  on(PeoplePage).search_for_user FigNewton.user1_surname
  on(PeoplePage).click_result FigNewton.user1_irlname
  on(UserOneProfilePage).click_content
  on(UserOneProfilePage).confirm_incident_report_invisible @subject
  on(UserOneProfilePage).click_thumbnail_view
  on(UserOneProfilePage).confirm_incident_report_invisible @subject
  on(UserOneProfilePage).filter_by @subject
  on(UserOneProfilePage).confirm_incident_report_invisible @subject
  on(UserOneProfilePage).log_out
end

Then /^participants are not able to view the discussion in the posters activity stream/ do
  visit(LoginPage).log_in username = FigNewton.user2_uname, password = FigNewton.user2_pswd
  on(HomePage).click_people
  on(PeoplePage).search_for_user FigNewton.user1_surname
  on(PeoplePage).click_result FigNewton.user1_irlname
  on(UserOneProfilePage).click_activity
  on(UserOneProfilePage).confirm_discussion_invisible @subject
  on(UserOneProfilePage).log_out
end

Then /^I am not able to view the discussion in my activity stream/ do
  visit(LoginPage).log_in
  on(HomePage).click_people
  on(PeoplePage).search_for_user FigNewton.user1_surname
  on(PeoplePage).click_result FigNewton.user1_irlname
  on(UserOneProfilePage).click_activity
  on(UserOneProfilePage).confirm_discussion_invisible @subject
  on(UserOneProfilePage).log_out
end

Given /^I attempt to view the profile of a non existent user$/ do
  on(HomePage).click_people
  on(PeoplePage).navigate_directly_to_profile_of 'invalid-user@nowhere'
end

Then /^I am notified that the user does not exist$/ do
  on(PeoplePage).verify_not_found
end