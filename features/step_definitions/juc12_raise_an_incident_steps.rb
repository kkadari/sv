Given /^I have mentioned "([^\"]+)" in? (?:a|an) (red|amber|green|white) incident report( anonymously)? in? (?:the|a) (community|private group|secret group|space)$/ do |user, marking, anonymous, location|
  @subject = TitleCreator.create_title_for('incident')
  @marking = marking
  @location = location
  user_profile = TestConfig.return_profile(user)
  mention = 'Some sample text <p><a class="jive_macro jive_macro_user" href="javascript:;" jivemacro="user" ___default_attr="' + user_profile[:user_id] + '" data-objecttype="3" data-orig-content="' + user_profile[:username] + '">' + user_profile[:username] + '</a></p>'

  payload = IncidentReportPayload.new(@subject, false, mention, @marking, {:type => @location}, '', anonymous).payload
  response = CreateContent.create_incident_report(payload, @browser.cookies.to_a)

  @incident_id = response['redirect'][/[0-9]+/,0]
  @incident_url = UrlFactory.incidentreportsummaryparampage + response['redirect']
end

Given /^I have raised a white incident report in a private group containing an internal link$/ do
  @subject = TitleCreator.create_title_for('incident')
  @marking = 'white'
  @location = 'private group'

  payload = IncidentReportPayload.new(@subject, false, @incident_url, @marking, {:type => @location}, '', false).payload
  response = CreateContent.create_incident_report(payload, @browser.cookies.to_a)
  @incident_id = response['redirect'][/[0-9]+/,0]
end

Then /^I can view the internal link$/ do
  visit_and_benchmark ViewIncidentReportPage, :using_params => {:id => @incident_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  fail 'Link not present' unless @browser.html.include? @incident_url
end

Then /^I am able to view the marking$/ do
  visit_and_benchmark ViewIncidentReportPage, :using_params => {:id => @incident_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(IncidentReportSummaryPage).ihm_bar.downcase.include? @marking
end

Then /^I can verify the anonymous identifiers have been added$/ do
  visit_and_benchmark ViewIncidentReportPage, :using_params => {:id => @incident_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(IncidentReportSummaryPage).ihm_bar.downcase.include? @marking

  fail 'Incident report not anonymous' unless @browser.html.to_s.include? 'This content was posted anonymously by its author'
end