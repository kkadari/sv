Given /^a participant has raised an anonymous incident report in a group I follow in my connections stream$/ do
  visit LoginPage do |creds|
    creds.populate_page_with :username => TestConfig.user1_uname, :password => TestConfig.user1_pswd
    creds.submit
  end

  visit CustomGroupPage do | customgroup |
    customgroup.follow unless customgroup.following_element.exists?
  end

  visit(LogoutPage)
  visit LoginPage do |creds|
    creds.populate_page_with :username => TestConfig.user2_uname, :password => TestConfig.user2_pswd
    creds.submit
  end

  @subject = TitleCreator.create_title_for('incident')

  on(GlobalNav) do |menu|
    menu.open_create
    menu.wait_until do
      menu.create_menu?
    end
    menu.create_incident_report
  end

  on CreateIncidentReportPage do |create|
    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation poll'
    create.handling_elements.each do |colour|
      colour.click if colour.text.downcase.include? 'amber'
    end
    create.publish_to         TestConfig.custom_group
    create.check_anonymous
    create.save
  end

  visit(LogoutPage)
end

Then /^I can verify the incident report is marked anonymous in my connection stream$/ do
  visit LoginPage do |creds|
    creds.populate_page_with :username => TestConfig.user1_uname, :password => TestConfig.user1_pswd
    creds.submit
  end
  on(HomePage).connections_stream

  incident_report = on(ActivityPage).incident_report.first
  !fail 'Not marked with anonymous avatar' unless incident_report.html.to_s.include? 'anonymous-avatar'
  !fail 'Not marked as anonymous' unless incident_report.text.include? 'Anonymous'
  !fail 'Username visible' if incident_report.text.include? TestConfig.user2_uname
end

Then /^I am not able to view it in their activity stream$/ do
  visit LoginPage do |creds|
    creds.populate_page_with :username => TestConfig.user2_uname, :password => TestConfig.user2_pswd
    creds.submit
  end

  visit(PeoplePage)
  on(PeoplePage).search TestConfig.user1_surname
  on(PeoplePage).search :return
  on(PeoplePage).user1_profile_link
  on(UserOneProfilePage).activity.when_present.click

  !fail 'Anonymous content visible' unless @browser.html.to_s.include? 'Anonymous'
end

Then /^I am not able to view their identity on the comment in their activity stream$/ do
  visit(PeoplePage)
  on(PeoplePage).search TestConfig.user1_surname
  on(PeoplePage).search :return
  on(PeoplePage).user1_profile_link
  on(UserOneProfilePage).activity.when_present.click
  .confirm_comment_is_anon

  on(UserOneActivityStreamPage).links.first.click
  !fail 'Not marked as anonymous' unless on(UserOneActivityStreamPage).comments.first.text.include? 'Anonymous'
  !fail 'Username visible' if on(UserOneActivityStreamPage).comments.first.text.include? TestConfig.user1_uname
end

Then /^another user is not able to view it in my activity stream$/ do
  visit LoginPage do |creds|
    creds.populate_page_with :username => TestConfig.user2_uname, :password => TestConfig.user2_pswd
    creds.submit
  end
  visit(PeoplePage)
  on(PeoplePage).search TestConfig.user1_surname
  on(PeoplePage).search :return
  on(PeoplePage).user1_profile_link
  on(UserOneProfilePage).activity.when_present.click

  !fail 'Anonymous content visible' unless @browser.html.to_s.include? 'Anonymous'
end

Then /^I can see the incident in my activity stream$/ do
  navigate_to(HomePage)
  fail 'Incident not visible or created' unless @browser.html.to_s.include? subject
end