Given /^a participant has raised an anonymous incident report in a group I follow in my connections stream$/ do
  switch_user('participant A')

  Follow.post_follow_group('2009', @browser.cookies.to_a)

  switch_user('participant B')

  @subject = TitleCreator.create_title_for('incident')

  payload = IncidentReportPayload.new(@subject, false, 'Lorem ipsumy goodness', 'random', {:type => 'space'}, '', true).payload
  response = CreateContent.create_incident_report(payload, @browser.cookies.to_a)
  @incident_id = response['redirect'][/[0-9]+/,0]
  @incident_url = UrlFactory.incidentreportsummaryparampage + response['redirect']
end

Then /^I can verify the incident report is marked anonymous in my connection stream$/ do
  switch_user('participant A')

  response = Feeds.get_activity(@browser.cookies.to_a)
  container = Nokogiri::HTML.parse(response).css('.j-act-content')[0].to_s

  fail 'Not marked with anonymous avatar' unless container.include? 'anonymous-avatar'
  fail 'Not marked as anonymous' unless container.include? 'Anonymous'
  fail 'Username visible' if container.include? @test_config_set[:user_2_name]
end

Then /^I am not able to view their identity on the comment in their activity stream$/ do
  response = People.post_ir_activity_comments(@incident_id, @browser.cookies.to_a)
  fail('Comment not anonymous') unless JSON.parse(response)['items'][0]['activityUser']['username'] == 'Anonymous'
end

Then /^another user is not able to view it in my activity stream$/ do
  switch_user('participant B')

  response = People.get_people_page(@test_config_set[:user_1_name], @browser.cookies.to_a)

  fail('Incident report found in activity stream') if response.include? @subject
end

Then /^I can see the incident in my activity stream$/ do
  navigate_to(HomePage)
  fail 'Incident not visible or created' unless @browser.html.to_s.include? subject
end

Given /^"([^"]*)" and "([^"]*)" are members of the same group$/ do |user1, user2|
  switch_user(user1)

  @id = Places.get_place_id(TestConfig.return_space, @browser.cookies.to_a)
  payload = FollowPayload.new(14,@id).payload

  Follow.post_follow_request(payload, @browser.cookies.to_a)

  switch_user(user2)

  payload = FollowPayload.new(14,@id).payload
  Follow.post_follow_request(payload, @browser.cookies.to_a)
end

When /^"([^"]*)" creates a new piece of content for the group$/ do |user|
  switch_user(user)

  @subject = TitleCreator.create_title_for('incident')

  payload = IncidentReportPayload.new(@subject, false, 'Lorem ipsumy goodness', 'amber', {:type => 'specific space', :id => @id}, '', true).payload
  CreateContent.create_incident_report(payload, @browser.cookies.to_a)
end

Then /^I will see the recently created content in my connections stream as "([^"]*)"$/ do |user|
  switch_user(user)
  sleep(2) # We have to sleep a couple of seconds to allow Jive to catch up and update the users activity stream *sigh*

  response = Feeds.get_activity(@browser.cookies.to_a)

  fail('Newly created content not found in content stream') unless Nokogiri::HTML.parse(response).css('.j-act-content')[0].text.include? @subject
end