Then /^I as admin can verify the anonymous identifiers have been added in their profile$/ do
  visit(PeoplePage)
  on(PeoplePage).search TestConfig.user1_surname
  on(PeoplePage).search :return
  on(PeoplePage).user1_profile_link
  on(UserOneProfilePage).content.when_present.click
  # Check content is there and anon
end

Then /^participants are not able to view the incident report on the posters profile$/ do
  visit LoginPage do |creds|
    creds.populate_page_with :username => TestConfig.user2_uname, :password => TestConfig.user2_pswd
    creds.submit
  end
  visit(PeoplePage)
  on(PeoplePage).search TestConfig.user1_surname
  on(PeoplePage).search :return
  on(PeoplePage).user1_profile_link
  on(UserOneProfilePage).content.when_present.click
  fail "Incident report visible, and should not be" if @browser.html.to_s.include? @subject
  on(UserOneProfilePage).thumbnail_view.when_present.click
  fail "Incident report visible, and should not be" if @browser.html.to_s.include? @subject
  on(UserOneProfilePage).filter_by.send_keys @subject
  on(UserOneProfilePage).filter_by.send_keys :return
  fail "Incident report visible, and should not be" if @browser.html.to_s.include? @subject
  visit(LogoutPage)
end

Then /^participants are not able to view the discussion in the posters activity stream/ do
  visit LoginPage do |creds|
    creds.populate_page_with :username => TestConfig.user2_uname, :password => TestConfig.user2_pswd
    creds.submit
  end
  visit(PeoplePage)
  on(PeoplePage).search TestConfig.user1_surname
  on(PeoplePage).search :return
  on(PeoplePage).user1_profile_link
  on(UserOneProfilePage).activity.when_present.click
  fail "Discussion is visible and should not be" if @browser.html.to_s.include? @subject
  visit(LogoutPage)
end

Then /^I am not able to view the discussion in my activity stream/ do
  visit LoginPage do |creds|
    creds.populate_page_with :username => TestConfig.user1_uname, :password => TestConfig.user1_pswd
    creds.submit
  end
  visit(PeoplePage)
  on(PeoplePage).search TestConfig.user1_surname
  on(PeoplePage).search :return
  on(PeoplePage).user1_profile_link
  on(UserOneProfilePage).activity.when_present.click
  fail "Discussion is visible and should not be" if @browser.html.to_s.include? @subject
  visit(LogoutPage)
end

Given /^I attempt to view the profile of a non existent user$/ do
  visit PeoplePage, :using_params => {:id => 'invalid-user@nowhere'}
end

Then /^I am notified that the user does not exist$/ do
  fail 'Person profile unexpectedly displayed' unless @browser.html.to_s.include? 'Not Found'
end
