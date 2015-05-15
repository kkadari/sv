Then /^I as admin can verify the anonymous identifiers have been added in their profile$/ do
  on(HomePage).click_people
  on(PeoplePage).search_for_user(TestConfig.user1_surname)
  on(PeoplePage).click_result(TestConfig.user1_irlname)
  on(UserOneProfilePage).content.when_present.click
  # Check content is there and anon
end

Then /^participants are not able to view the incident report on the posters profile$/ do
  visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd
  on(HomePage).click_people
  on(PeoplePage).search_for_user(TestConfig.user1_surname)
  on(PeoplePage).click_result(TestConfig.user1_irlname)
  on(UserOneProfilePage).content.when_present.click
  fail "Incident report visible, and should not be" if @browser.html.to_s.include? @subject
  on(UserOneProfilePage).thumbnail_view.when_present.click
  fail "Incident report visible, and should not be" if @browser.html.to_s.include? @subject
  on(UserOneProfilePage).filter_by.send_keys @subject
  on(UserOneProfilePage).filter_by.send_keys :return
  fail "Incident report visible, and should not be" if @browser.html.to_s.include? @subject
  on(UserOneProfilePage).log_out
end

Then /^participants are not able to view the discussion in the posters activity stream/ do
  visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd
  on(HomePage).click_people
  on(PeoplePage).search_for_user(TestConfig.user1_surname)
  on(PeoplePage).click_result(TestConfig.user1_irlname)
  on(UserOneProfilePage).activity.when_present.click
  fail "Discussion is visible and should not be" if @browser.html.to_s.include? @subject
  on(UserOneProfilePage).log_out
end

Then /^I am not able to view the discussion in my activity stream/ do
  visit(LoginPage).log_in
  on(HomePage).click_people
  on(PeoplePage).search_for_user(TestConfig.user1_surname)
  on(PeoplePage).click_result(TestConfig.user1_irlname)
  on(UserOneProfilePage).activity.when_present.click
  fail "Discussion is visible and should not be" if @browser.html.to_s.include? @subject
  on(UserOneProfilePage).log_out
end

Given /^I attempt to view the profile of a non existent user$/ do
  on(PeoplePage).navigate_directly_to_profile_of 'invalid-user@nowhere'
end

Then /^I am notified that the user does not exist$/ do
  fail 'Person profile unexpectedly displayed' unless @browser.html.to_s.include? 'Not Found'
end
