Then /^participants are not able to view the incident report on the posters profile$/ do
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant B']

  visit_and_benchmark UserOneProfilePage, :using_params => {:id => @test_config_set[:user_1_name]}
  on(UserOneProfilePage).content
  fail 'Incident report visible, and should not be' if @browser.html.to_s.include? @subject
  on(UserOneProfilePage).thumbnail_view
  fail 'Incident report visible, and should not be' if @browser.html.to_s.include? @subject
  on(UserOneProfilePage).filter_by = @subject
  on(UserOneProfilePage).filter_by = :return
  fail 'Incident report visible, and should not be' if @browser.html.to_s.include? @subject
end

Then /^participants are not able to view the discussion in the posters activity stream/ do
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant B']

  visit_and_benchmark UserOneProfilePage, :using_params => {:id => @test_config_set[:user_1_name]}
  on(UserOneProfilePage).activity
  fail 'Discussion is visible and should not be' if @browser.html.to_s.include? @subject
end

Then /^I am not able to view the discussion in my activity stream/ do
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant B']

  visit_and_benchmark UserOneProfilePage, :using_params => {:id => @test_config_set[:user_1_name]}
  on(UserOneProfilePage).activity
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

Then /^I as admin can verify the anonymous identifiers have been added in their profile$/ do
  response = Content.get_ir(@incident_id, @browser.cookies.to_a)

  fail('IR not marked as anonymous') unless Nokogiri::HTML.parse(response).css('.j-byline') unless '<span class="anonymous-badge" title="This content was posted anonymously by its author">'
end
