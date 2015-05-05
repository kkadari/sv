Given /^I have mentioned "([^\"]+)" in? (?:a|an) (red|amber|green|white) incident report( anonymously)? in? (?:the|a) (community|private group|secret group|space)$/ do |user, marking, anonymous, location|
  @subject = on(HomePage).create_title_for('incident')
  @marking = marking
  @location = location

  response = Request.create_incident_report @browser.cookies.to_a, @subject, "Some sample text <p><a class='jive_macro jive_macro_user' href='javascript:;' jivemacro='user' ___default_attr='2013' data-objecttype='3' data-orig-content='simonwhi@surevine'>simonwhi@surevine</a></p>", @marking, Hash[:type => @location], "", anonymous
  @incident_id = response['redirect'][/[0-9]+/,0]
  @incident_url = FigNewton.base_url + response['redirect']
end

Given /^I have raised a white incident report in a private group containing an internal link$/ do
  @subject = on(HomePage).create_title_for('incident')
  @marking = 'white'
  @location = 'private group'
  # on(HomePage).click_home
  # on(HomePage).create('incident_report')
  # on(IncidentReportPage).set_ihm_level(@marking)
  # on(IncidentReportPage).set_publish_level(@location)
  # on(IncidentReportPage).complete_incident_report :subject => @subject, :body => @incident_url
  # on(IncidentReportSummaryPage).verify_content_exists(@subject)
  # on(IncidentReportSummaryPage).correct_ihm_displayed(@marking)

  Request.create_incident_report @browser.cookies.to_a, @subject, @incident_url, @marking, Hash[:type => @location], "", false
end

Then /^I can view the internal link$/ do
  on(HomePage).click_content
  on(ContentPage).navigate_to_ir_named(@subject)
  on(IncidentReportSummaryPage).verify_content_exists(@subject)
  fail "Link not present" unless @browser.html.include? @incident_url
end