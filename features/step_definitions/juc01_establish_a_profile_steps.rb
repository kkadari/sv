Given /^I have enhanced my profile$/ do
  @prefix = Faker::Name.prefix
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant A']

  visit_and_benchmark UserOneProfileEditPage do |edit|
    edit.title = @prefix
    edit.save
  end

end

Then /^participants that follow me can view the profile enhancements$/ do
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant B']

  visit_and_benchmark(PeoplePage)
  on(PeoplePage).user1_profile_link
  on(UserOneProfilePage).view_more_details.click

  fail('Could not find profile enhancement') unless @browser.html.to_s.include? @prefix
end

Given /^I have restricted parts of my profile$/ do
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant A']

  visit_and_benchmark UserOnePrivacyEditPage do |edit|
    edit.security_level = 'Connections'
    edit.save
  end
end

Then /^followers can see restrictions$/ do
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant B']

  on(PeoplePage).user1_profile_link
  fail 'Name not visible, and should be' unless @browser.html.include? @test_config_set[:user_1_name]
end

And /^non followers cannot see restrictions$/ do
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant B']

  on(PeoplePage).user1_profile_link
  fail 'Name visible, and should not be' if @browser.html.to_s.include? @test_config_set[:user_1_name]
end
