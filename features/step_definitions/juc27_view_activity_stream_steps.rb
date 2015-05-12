Given /^a participant has raised an anonymous incident report in a group I follow in my connections stream$/ do
  visit(LoginPage).log_in
  on(HomePage).click_places

  on(PlacesPage).view_custom_group
  on(CustomGroupPage).follow_in_connections_stream
  on(CustomGroupPage).log_out
  @subject = on(HomePage).create_title_for('incident')
  visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd
  on(HomePage).create('incident_report')
  on(IncidentReportPage).set_ihm_level('amber')
  on(IncidentReportPage).publish_to(TestConfig.custom_group)
  on(IncidentReportPage).raise_anonymously
  on(IncidentReportPage).complete_incident_report :subject => @subject

  on(IncidentReportSummaryPage).log_out
end

Then /^I can verify the incident report is marked anonymous in my connection stream$/ do
  visit(LoginPage).log_in
  on(HomePage).navigate_to_connections_stream
  on(ActivityPage).confirm_first_ir_is_anonymous
  on(ActivityPage).log_out
end

Then /^I am not able to view it in their activity stream$/ do
  visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd
  on(HomePage).click_people
  on(PeoplePage).search_for_user TestConfig.user1_surname
  on(PeoplePage).click_result TestConfig.user1_irlname
  on(UserOneProfilePage).click_activity
  on(UserOneActivityStreamPage).confirm_no_anon_content
end

Then /^I am not able to view their identity on the comment in their activity stream$/ do
  on(HomePage).click_people
  #TODO: Allow a user to be passed in ~TD
  on(PeoplePage).search_for_user(TestConfig.user1_surname)
  on(PeoplePage).click_result(TestConfig.user1_irlname)
  on(UserOneProfilePage).click_activity
  on(UserOneActivityStreamPage).confirm_comment_is_anon
end

Then /^another user is not able to view it in my activity stream$/ do
  visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd
  on(HomePage).click_people
  on(PeoplePage).search_for_user TestConfig.user1_surname
  on(PeoplePage).click_result TestConfig.user1_irlname
  on(UserOneProfilePage).click_activity
  on(UserOneActivityStreamPage).confirm_no_anon_content
end
