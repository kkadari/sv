Given /^I have enhanced my profile$/ do
  @alt_email = Faker::Internet.email
  visit(LoginPage).log_in
  navigate_to(UserOneProfileEditPage, :using => :user1_profile_route).update_profile 'alt_email' => @alt_email
  on(UserOneProfilePage).log_out
end

Then /^participants that follow me can view the profile enhancements$/ do
  visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd
  navigate_to(PeoplePage, :using => :user1_profile_route).view_profile 'user1'
  on(UserOneProfilePage).confirm_field_updated @alt_email
end

Given /^I have restricted parts of my profile$/ do
  visit(LoginPage).log_in
  navigate_to(UserOnePrivacyEditPage, :using => :user1_profile_route).restrict_name
  on(UserOneProfilePage).log_out
end

Then /^followers can see restrictions$/ do
  visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd
  navigate_to(PeoplePage, :using => :user1_profile_route).view_profile 'user1'
  on(UserOneProfilePage).confirm_restriction_visible
  on(UserOneProfilePage).log_out
end

And /^non followers cannot see restrictions$/ do
  visit(LoginPage).log_in TestConfig.user3_uname, TestConfig.user3_pswd
  navigate_to(PeoplePage, :using => :user1_profile_route).view_profile 'user1'
  on(UserOneProfilePage).confirm_restriction_invisible
end
