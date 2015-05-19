Given /^I have enhanced my profile$/ do
  @prefix = Faker::Name.prefix
  visit(LoginPage).log_in TestConfig.user1_uname, TestConfig.user1_pswd

  visit(UserOneProfileEditPage)
  on UserOneProfileEditPage do |edit|
    edit.title = @prefix
    edit.save
  end

end

Then /^participants that follow me can view the profile enhancements$/ do
  visit(LogoutPage)
  visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd

  visit(PeoplePage)
  on(PeoplePage).user1_profile
  on(UserOneProfilePage).view_more_details.click

  fail('Could not find profile enhancement') unless @browser.html.to_s.include? @prefix
end

Given /^I have restricted parts of my profile$/ do
  visit(LoginPage).log_in
  navigate_to(UserOnePrivacyEditPage, :using => :user1_profile_route).restrict_name
  visit(LogoutPage)
end

Then /^followers can see restrictions$/ do
  visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd
  on(PeoplePage).user1_profile
  fail 'Name not visible, and should be' unless @browser.html.include? TestConfig.user1_irlname
  visit(LogoutPage)
end

And /^non followers cannot see restrictions$/ do
  visit(LoginPage).log_in TestConfig.user3_uname, TestConfig.user3_pswd
  on(PeoplePage).user1_profile
  fail 'Name visible, and should not be' if @browser.html.to_s.include? TestConfig.user1_irlname
end
