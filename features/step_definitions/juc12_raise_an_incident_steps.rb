Given /^I have raised? (?:a|an) (red|amber|green|white) incident report( anonymously)? in? (?:the|a) (community|private group|secret group|space)$/ do |marking, anonymous, location|
  @subject = on(HomePage).create_title_for('incident')
  @marking = marking
  @location = location
  on(HomePage).create('incident_report')
  on(IncidentReportPage).set_ihm_level(@marking)
  on(IncidentReportPage).set_publish_level(@location)
  if (anonymous)
    on(IncidentReportPage).raise_anonymously
  end
  on(IncidentReportPage).complete_incident_report :subject => @subject
  on(IncidentReportSummaryPage).verify_content_exists(@subject)
  on(IncidentReportSummaryPage).correct_ihm_displayed(@marking)
  @incident_id = on(IncidentReportSummaryPage).capture_incident_id
  @incident_url = on(IncidentReportSummaryPage).capture_url
end

Given /^I have mentioned "([^\"]+)" in? (?:a|an) (red|amber|green|white) incident report( anonymously)? in? (?:the|a) (community|private group|secret group|space)$/ do |user, marking, anonymous, location|
  @subject = on(HomePage).create_title_for('incident')
  @user = user
  @marking = marking
  @location = location
  on(HomePage).create('incident_report')
  on(IncidentReportPage).set_ihm_level(@marking)
  on(IncidentReportPage).set_publish_level(@location)
  if (anonymous)
    on(IncidentReportPage).raise_anonymously
  end
  # Insert some mention method from the mention_module here.
  on(IncidentReportPage).complete_incident_report :subject => @subject, :body => 'Some sample text <body><p><a class="jive_macro jive_macro_user" href="javascript:;" jivemacro="user" ___default_attr="2013" data-objecttype="3" data-orig-content="simonwhi@surevine">simonwhi@surevine</a></p></body>'
  on(IncidentReportSummaryPage).verify_content_exists(@subject)
  on(IncidentReportSummaryPage).correct_ihm_displayed(@marking)
  @incident_id = on(IncidentReportSummaryPage).capture_incident_id
  @incident_url = on(IncidentReportSummaryPage).capture_url
end

Then /^my inbox shows I have been mentioned( anonymously)?$/ do |anonymously|
  @browser.link(:href => "/inbox").when_present.click
  @browser.span(:class => 'title').when_present.click
  sleep 2
  fail "IR not visible" unless @browser.html.include? @subject
  if (anonymously)
    fail "Author visible" unless @browser.divs(:class => "j-author-act font-color-meta-light", :text => "Anonymous")
  end
end

Given /^I have raised a white incident report in a private group containing an internal link$/ do
  @subject = on(HomePage).create_title_for('incident')
  @marking = 'white'
  @location = 'private group'
  on(HomePage).click_home
  on(HomePage).create('incident_report')
  on(IncidentReportPage).set_ihm_level(@marking)
  on(IncidentReportPage).set_publish_level(@location)
  on(IncidentReportPage).complete_incident_report :subject => @subject, :body => @incident_url
  on(IncidentReportSummaryPage).verify_content_exists(@subject)
  on(IncidentReportSummaryPage).correct_ihm_displayed(@marking)
end

Then /^I can view the internal link$/ do
  on(HomePage).click_content
  on(ContentPage).navigate_to_ir_named(@subject)
  on(IncidentReportSummaryPage).verify_content_exists(@subject)
  fail "Link not present" unless @browser.html.include? @incident_url
end