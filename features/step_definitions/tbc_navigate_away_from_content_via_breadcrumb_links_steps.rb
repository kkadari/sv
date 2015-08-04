Given /^I have navigated away from a poll using the breadcrumb links$/ do
  switch_user('participant A')

  @subject = TitleCreator.create_title_for('poll')

  response1 = CreateContent.get_create_poll(@browser.cookies.to_a)
  poll_id = Nokogiri::HTML.parse(response1).css('input[name="pollID"]')[0]['value']

  response2 = CreateContent.get_poll_choice(poll_id, @browser.cookies.to_a)
  choice = JSON.parse(response2)['id']

  payload = PollPayload
                .new(@browser.cookies.to_a,
                     poll_id,
                     choice,
                     @subject,
                     'Test automation poll',
                     'amber',
                     'Option ',
                     {:type => 'community'}).payload

  response = CreateContent.post_create_poll(payload, @browser.cookies.to_a)

  poll_id = JSON.parse(response)['redirect'].scan(/polls\/[0-9]*/)[0].gsub('polls/','')

  @response = Content.get_poll(poll_id, @browser.cookies.to_a)
end

Then /I am able to view more polls in a related container$/ do
  fail 'Not on correct content page' unless Nokogiri::HTML.parse(@response).css('.j-context > a')[0].to_s.include? "/people/#{@test_config_set[:user_1_name].gsub('@','%40')}/content?filterID=contentstatus%5Bpublished%5D~objecttype~objecttype%5Bpoll%5D"
end

Given /^I am viewing an incident report$/ do
  switch_user('participant A')
  subject = TitleCreator.create_title_for('incident')

  payload = IncidentReportPayload.new(subject, false, 'Lorem ipsumy goodness', 'white', {:type => 'community'}, '', false).payload
  response = CreateContent.create_incident_report(payload, @browser.cookies.to_a)
  incident_id = response['redirect'][/[0-9]+/,0]

  @response = Content.get_ir(incident_id, @browser.cookies.to_a)
end

Then /^I am able to view more incident reports in a related container$/ do
  fail('Related link not found') unless Nokogiri::HTML.parse(@response).css('.j-context > a')[0].to_s.include? '/content?filterID=contentstatus%5Bpublished%5D~objecttype~objecttype%5Bincidentreport%5D'
end

Given /^I am viewing a discussion$/ do
  switch_user('participant A')
  subject = TitleCreator.create_title_for('discussion')

  payload = DiscussionPayload.new(subject, false, 'Lorem ipsumy goodness', 'white', {:type => 'community'}, '', false).payload
  response = CreateContent.create_discussion(payload, @browser.cookies.to_a)
  discussion_id = response['redirect'][/[0-9]+/,0]

  @response = Content.get_message(discussion_id, @browser.cookies.to_a)
end

Then /^I am able to view more discussion in a related container$/ do
  fail('Related link not found') unless Nokogiri::HTML.parse(@response).css('.j-context > a')[0].to_s.include? '/content?filterID=contentstatus%5Bpublished%5D~objecttype~objecttype%5Bthread%5D'
end