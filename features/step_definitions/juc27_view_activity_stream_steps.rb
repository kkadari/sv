Given /^a participant has raised an anonymous incident report in a group I follow in my connections stream$/ do
  visit(LoginPage).log_in TestConfig.user1_uname, TestConfig.user1_pswd

  visit CustomGroupPage do | customgroup |
    customgroup.follow_in_connections_stream
  end

  visit(LogoutPage)
  visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd

  @subject = on(HomePage).create_title_for('incident')
  on(HomePage).create('incident_report')

  on CreateIncidentReportPage do |create|
    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation poll'
    create.set_ihm_level      'amber'
    create.publish_to         TestConfig.custom_group
    create.check_anonymous
    create.save
  end

  visit(LogoutPage)
end

Then /^I can verify the incident report is marked anonymous in my connection stream$/ do
  visit(LoginPage).log_in TestConfig.user1_uname, TestConfig.user1_pswd
  on(HomePage).connections_stream

  incident_report = on(ActivityPage).incident_report.first
  !fail 'Not marked with anonymous avatar' unless incident_report.html.to_s.include? 'anonymous-avatar'
  !fail 'Not marked as anonymous' unless incident_report.text.include? 'Anonymous'
  !fail 'Username visible' if incident_report.text.include? TestConfig.user2_uname
end

Then /^I am not able to view it in their activity stream$/ do
  visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd
  on(HomePage).people
  on(PeoplePage).search_for_user TestConfig.user1_surname
  on(PeoplePage).click_result TestConfig.user1_irlname
  on(UserOneProfilePage).activity.when_present.click

  !fail 'Anonymous content visible' unless @browser.html.to_s.include? 'Anonymous'
end

Then /^I am not able to view their identity on the comment in their activity stream$/ do
  on(HomePage).people
  #TODO: Allow a user to be passed in ~TD
  on(PeoplePage).search_for_user(TestConfig.user1_surname)
  on(PeoplePage).click_result(TestConfig.user1_irlname)
  on(UserOneProfilePage).activity.when_present.click
  .confirm_comment_is_anon

  on(UserOneActivityStreamPage).links.first.click
  !fail 'Not marked as anonymous' unless on(UserOneActivityStreamPage).comments.first.text.include? 'Anonymous'
  !fail 'Username visible' if on(UserOneActivityStreamPage).comments.first.text.include? TestConfig.user1_uname
end

Then /^another user is not able to view it in my activity stream$/ do
  visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd
  on(HomePage).people
  on(PeoplePage).search_for_user TestConfig.user1_surname
  on(PeoplePage).click_result TestConfig.user1_irlname
  on(UserOneProfilePage).activity.when_present.click

  !fail 'Anonymous content visible' unless @browser.html.to_s.include? 'Anonymous'
end

Then /^I can see the incident in my activity stream$/ do
  navigate_to(HomePage)
  fail 'Incident not visible or created' unless @browser.html.to_s.include? subject
end