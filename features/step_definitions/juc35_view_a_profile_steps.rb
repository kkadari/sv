Then /^I as admin can verify the anonymous identifiers have been added in their profile$/ do
  visit_and_benchmark(PeoplePage)
  on(PeoplePage).search @test_config_set[:user_1_name]
  on(PeoplePage).search :return
  on(PeoplePage).user1_profile_link
  on(UserOneProfilePage).content.when_present.click
  # Check content is there and anon
end

Then /^participants are not able to view the incident report on the posters profile$/ do
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant B']

  visit_and_benchmark(PeoplePage)
  on(PeoplePage).search @test_config_set[:user_1_name]
  on(PeoplePage).search :return
  on(PeoplePage).user1_profile_link
  on(UserOneProfilePage).content.when_present.click
  fail 'Incident report visible, and should not be' if @browser.html.to_s.include? @subject
  on(UserOneProfilePage).thumbnail_view.when_present.click
  fail 'Incident report visible, and should not be' if @browser.html.to_s.include? @subject
  on(UserOneProfilePage).filter_by.send_keys @subject
  on(UserOneProfilePage).filter_by.send_keys :return
  fail 'Incident report visible, and should not be' if @browser.html.to_s.include? @subject
end

Then /^participants are not able to view the discussion in the posters activity stream/ do
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant B']

  visit_and_benchmark(PeoplePage)
  on(PeoplePage).search @test_config_set[:user_1_name]
  on(PeoplePage).search :return
  on(PeoplePage).user1_profile_link
  on(UserOneProfilePage).activity.when_present.click
  fail 'Discussion is visible and should not be' if @browser.html.to_s.include? @subject
end

Then /^I am not able to view the discussion in my activity stream/ do
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant A']

  visit_and_benchmark(PeoplePage)
  on(PeoplePage).search @test_config_set[:user_1_name]
  on(PeoplePage).search :return
  on(PeoplePage).user1_profile_link
  on(UserOneProfilePage).activity.when_present.click
  fail 'Discussion is visible and should not be' if @browser.html.to_s.include? @subject
end

Given /^I attempt to view the profile of a non existent user$/ do
  visit_and_benchmark PeoplePage, :using_params => {:id => 'invalid-user@nowhere'}
end

Then /^I am notified that the user does not exist$/ do
  fail 'Person profile unexpectedly displayed' unless @browser.html.to_s.include? 'Not Found'
end

When /^I attempt to view the profile of an existing user$/ do
  visit_and_benchmark AdvancedSearchPage do |search|
    search.people
    search.search_query = 'a*'
    search.submit_search

    search.wait_until do
      search.search_container?
    end

    search.top_result
  end
end

Then /^I am shown that users profile details$/ do
  on(UserOneProfilePage).wait_until do
    on(UserOneProfilePage).profile_element.exists?
  end

  fail('Profile not displayed') unless on(UserOneProfilePage).profile_element.exists?
  fail('Organisation not displayed') unless on(UserOneProfilePage).organisation?
  fail('Skills not displayed') unless on(UserOneProfilePage).skills?
end
