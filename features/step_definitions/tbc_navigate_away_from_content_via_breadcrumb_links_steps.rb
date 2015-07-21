Given /^I have navigated away from a poll using the breadcrumb links$/ do
  @subject = TitleCreator.create_title_for('poll')

  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant A']

  visit_and_benchmark CreatePollPage do |create|
    create.select_community
    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation poll'
    create.option1          = 'Option 1 to choose'
    create.option2          = 'Option 2 to choose'
    create.handling_elements.each do |colour|
      colour.click if colour.text.downcase.include? 'amber'
    end
    create.save
  end

  on(PollSummaryPage).wait_until do
    on(PollSummaryPage).title?
  end

  on(PollSummaryPage).breadcrumb
end

Then /I am able to view more polls in a related container$/ do
  fail 'Not on correct content page' unless @browser.url.include? "/people/#{@test_config_set[:user_1_name].gsub('@','%40')}/content?filterID=contentstatus[published]~objecttype~objecttype[poll]"
end

Given /^I am viewing an incident report$/ do
  switch_user('participant A')
  subject = TitleCreator.create_title_for('incident')

  response = CreateContent.create_incident_report @browser.cookies.to_a, subject, 'Lorem ipsumy goodness', 'white', Hash[:type => 'community'], "", false
  incident_id = response['redirect'][/[0-9]+/,0]

  @response = Content.get_ir(incident_id, @browser.cookies.to_a)
end

Then /^I am able to view more incident reports in a related container$/ do
  fail('Related link not found') unless Nokogiri::HTML.parse(@response).css('.j-context > a')[0].to_s.include? '/content?filterID=contentstatus%5Bpublished%5D~objecttype~objecttype%5Bincidentreport%5D'
end

Given /^I am viewing a discussion$/ do
  switch_user('participant A')
  subject = TitleCreator.create_title_for('discussion')

  response = CreateContent.create_discussion @browser.cookies.to_a, subject, false, 'Lorem ipsumy goodness', 'white', Hash[:type => 'community'], '', false
  discussion_id = response['redirect'][/[0-9]+/,0]

  @response = Content.get_message(discussion_id, @browser.cookies.to_a)
end

Then /^I am able to view more discussion in a related container$/ do
  fail('Related link not found') unless Nokogiri::HTML.parse(@response).css('.j-context > a')[0].to_s.include? '/content?filterID=contentstatus%5Bpublished%5D~objecttype~objecttype%5Bthread%5D'
end