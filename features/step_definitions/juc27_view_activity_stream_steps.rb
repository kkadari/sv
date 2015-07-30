Given /^a participant has raised an anonymous incident report in a group I follow in my connections stream$/ do
  switch_users('participant A')

  visit_and_benchmark CustomGroupPage, :using_params => {:id => @test_config_set[:private_group]} do | customgroup |
    customgroup.follow unless customgroup.following_element.exists?
  end

  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant B']

  @subject = TitleCreator.create_title_for('incident')

  response = CreateContent.create_incident_report @browser.cookies.to_a, @subject, 'Lorem ipsumy goodness', 'random', Hash[:type => 'private group'], '', true
  @incident_id = response['redirect'][/[0-9]+/,0]
  @incident_url = UrlFactory.incidentreportsummaryparampage + response['redirect']
end

Then /^I can verify the incident report is marked anonymous in my connection stream$/ do
  switch_users('participant A')

  visit_and_benchmark ActivityPage do |act|
    act.connections_stream
    @incident_report = act.incident_report_element
    act.wait_until do
      act.header.include? 'Connections Stream'
    end
  end

  !fail 'Not marked with anonymous avatar' unless @incident_report.html.to_s.include? 'anonymous-avatar'
  !fail 'Not marked as anonymous' unless @incident_report.text.include? 'Anonymous'
  !fail 'Username visible' if @incident_report.text.include? @test_config_set[:user_2_name]
end

Then /^I am not able to view their identity on the comment in their activity stream$/ do
  visit_and_benchmark PeoplePage, :using_params => {:id => @test_config_set[:user_2_name]}
  on(UserOneProfilePage).activity
  on(UserOneActivityStreamPage).show_all
  on(UserOneActivityStreamPage).wait_until do
    on(UserOneActivityStreamPage).comment?
  end

  !fail 'Not marked as anonymous' unless on(UserOneActivityStreamPage).comment.include? 'Anonymous'
  !fail 'Username visible' if on(UserOneActivityStreamPage).comment.include? @test_config_set[:user_1_name]
end

Then /^another user is not able to view it in my activity stream$/ do
  switch_users('participant B')

  visit_and_benchmark PeoplePage, :using_params => {:id => @test_config_set[:user_1_name]}

  !fail 'Anonymous content visible' unless @browser.html.to_s.include? 'Anonymous'
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

  CreateContent.create_incident_report @browser.cookies.to_a, @subject, 'Lorem ipsumy goodness', 'amber', Hash[:type => 'specific space', :id => @id], '', true
end

Then /^I will see the recently created content in my connections stream as "([^"]*)"$/ do |user|
  switch_user(user)
  sleep(2) # We have to sleep a couple of seconds to allow Jive to catch up and update the users activity stream *sigh*

  response = Feeds.get_activity(@browser.cookies.to_a)

  fail('Newly created content not found in content stream') unless Nokogiri::HTML.parse(response).css('.j-act-content')[0].text.include? @subject
end