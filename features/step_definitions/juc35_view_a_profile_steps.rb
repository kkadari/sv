Then /^participants are not able to view the incident report on the posters profile$/ do
  switch_user('participant B')

  response = People.get_people_activity(@test_config_set[:user_1_name], $authorisation)

  container = Nokogiri::HTML.parse(response).css('.j-act-content')[0].to_s
  fail 'Incident report visible, and should not be' if container.include? @subject
end

Then /^participants are not able to view the discussion in the posters activity stream/ do
  switch_user('participant B')

  response = People.get_people_activity(@test_config_set[:user_1_name], $authorisation)
  container = Nokogiri::HTML.parse(response).css('.j-act-content')[0].to_s
  fail 'Discussion is visible and should not be' if container.include? @subject
end

Then /^I am not able to view the discussion in my activity stream/ do
  switch_user('participant B')

  response = People.get_people_activity(@test_config_set[:user_1_name], $authorisation)
  container = Nokogiri::HTML.parse(response).css('.j-act-content')[0].to_s
  fail 'Discussion is visible and should not be' if container.include? @subject
end

Given /^I attempt to view the profile of a non existent user$/ do
  @response = People.get_people_page('madeup@user', $authorisation, 404)
end

Then /^I am notified that the user does not exist$/ do
  fail 'Person profile unexpectedly displayed' unless @response.code == 404
end

Then /^I as admin can verify the anonymous identifiers have been added in their profile$/ do
  response = Content.get_ir(@incident_id, $authorisation)

  fail('IR not marked as anonymous') unless Nokogiri::HTML.parse(response).css('.j-byline').to_s.include? '<span class="anonymous-badge" title="This content was posted anonymously by its author">'
end


################ SMOKE TEST STEPS ##################

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