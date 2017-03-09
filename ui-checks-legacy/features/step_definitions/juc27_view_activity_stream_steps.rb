Given /^a participant has raised an anonymous incident report in a group I follow in my connections stream$/ do
  switch_user('participant A')

  Follow.post_follow_group($custom_space_id, $authorisation)

  switch_user('participant B')

  @subject = TitleCreator.create_title_for('incident')

  payload = IncidentReportPayload.new(@subject, false, 'Lorem ipsumy goodness', 'random', {:type => 'space'}, '', true).payload
  response = CreateContent.create_incident_report(payload, $authorisation)
  @incident_id = response['redirect'][/[0-9]+/,0]
  @incident_url = UrlFactory.incidentreportsummaryparampage + response['redirect']
end

Then /^I can verify the incident report is marked anonymous in my connection stream$/ do
  5.times do |i|
    begin
      switch_user('participant A')

      response = Feeds.get_activity($authorisation)
      container = Nokogiri::HTML.parse(response).css('.j-act-content')[0].to_s

      fail 'Not marked with anonymous avatar' unless container.include? 'anonymous-avatar'
      fail 'Not marked as anonymous' unless container.include? 'Anonymous'
      fail 'Username visible' if container.include? @test_config_set[:user_2_name]
      break
    rescue => e
      if i < 5
        sleep(1)
      else
        fail(e)
      end
    end
  end
end

Then /^I am not able to view their identity on the comment in their activity stream$/ do
  5.times do |i|
    begin
      response = People.post_ir_activity_comments(@incident_id, $authorisation)
      fail('Comment not anonymous') unless JSON.parse(response)['items'][0]['activityUser']['username'] == 'Anonymous'
      break
    rescue => e
      if i < 5
        sleep(1)
      else
        fail(e)
      end
    end
  end
end

Then /^another user is not able to view it in my activity stream$/ do
  switch_user('participant B')

  response = People.get_people_page(@test_config_set[:user_1_name], $authorisation)

  fail('Incident report found in activity stream') if response.include? @subject
end

Then /^I can see the incident in my activity stream$/ do
  navigate_to(HomePage)
  fail 'Incident not visible or created' unless @browser.html.to_s.include? subject
end

Given /^"([^"]*)" and "([^"]*)" are members of the same group$/ do |user1, user2|
  switch_user(user1)

  @id = Places.get_place_id(TestConfig.return_space, $authorisation)
  payload = FollowPayload.new(14,@id).payload

  Follow.post_follow_request(payload, $authorisation)

  switch_user(user2)

  payload = FollowPayload.new(14,@id).payload
  Follow.post_follow_request(payload, $authorisation)
end

When /^"([^"]*)" creates a new piece of content for the group$/ do |user|
  switch_user(user)

  @subject = TitleCreator.create_title_for('incident')

  payload = IncidentReportPayload.new(@subject, false, 'Lorem ipsumy goodness', 'amber', {:type => 'specific space', :id => @id}, '', true).payload
  CreateContent.create_incident_report(payload, $authorisation)
end

Then /^I will see the recently created content in my connections stream as "([^"]*)"$/ do |user|
  5.times do |i|
    begin
      switch_user(user)

      response = Feeds.get_activity($authorisation)

      fail('Newly created content not found in content stream') unless Nokogiri::HTML.parse(response).css('.j-act-content')[0].text.include? @subject
      break
    rescue => e
      if i < 5
        sleep(1)
      else
        fail(e)
      end
    end
  end
end
