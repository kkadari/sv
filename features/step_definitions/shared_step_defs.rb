Given /^I? (?:am|have) logged in as "([^\"]+)"$/ do |login|

  @user_logged_in = @browser.link(:id => 'j-satNav').present?
  if @user_logged_in then
    visit(HomePage).log_out
  end

  user = "#{login}"
  case user
    when 'participant A'
      visit(LoginPage).log_in TestConfig.user1_uname, TestConfig.user1_pswd
    when 'participant B'
      visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd
    when 'admin'
      visit(LoginPage).log_in TestConfig.adminuser_uname, TestConfig.adminuser_pswd
    else
      fail 'Supplied user not recognised.'
  end

  #A quick hack to force the tests to use one node until the load balancer has been fixed
  @browser.cookies.delete('JSESSIONID')
  @browser.cookies.add 'JSESSIONID', 'dev141~24DBD919EEF5F05E808A148B27231227'
  @browser.refresh
end

Given /^I have quickly raised? (?:a|an) (red|amber|green|white) incident report( anonymously)? in? (?:the|a) (community|private group|secret group|space)$/ do |marking, anonymous, location|
  @subject = on(HomePage).create_title_for('incident')
  @marking = marking
  @location = location

  response = Request.create_incident_report @browser.cookies.to_a, @subject, "Lorem ipsumy goodness", @marking, Hash[:type => @location], "", anonymous
  @incident_id = response['redirect'][/[0-9]+/,0]
  @incident_url = UrlFactory.incidentreportsummaryparampage + response['redirect']
end

Then /^I? (?:can|have)? (?:comment|commented) on the incident report( anonymously)?$/ do |anonymous|
  on(HomePage).click_content
  on(ContentPage).navigate_to_ir_named(@subject)
  if (anonymous)
    on(ViewIncidentReportPage).add_comment_anonymously
  else
    on(ViewIncidentReportPage).add_comment
  end
end

Given /^I have created? (?:a|an) (red|amber|green|white) discussion( question)?( anonymously)? in? (?:the|a) (community|private group|secret group|space)$/ do |marking, question, anonymous, location|
  @subject = on(HomePage).create_title_for('discussion')
  @marking = marking
  @location = location
  on(HomePage).create('discussion')
  on(DiscussionPage).set_ihm_level(@marking)
  on(DiscussionPage).set_publish_level(@location)
  if (question)
    on(DiscussionPage).mark_as_question
  end
  if (anonymous)
    on(DiscussionPage).raise_anonymously
  end
  on(DiscussionPage).complete_discussion :subject => @subject
  on(DiscussionSummaryPage).verify_content_exists(@subject)
  on(DiscussionSummaryPage).correct_ihm_displayed(@marking)
  if (anonymous)
    on(DiscussionSummaryPage).verify_anonymous
  end
end

Given /^I have quickly created? (?:a|an) (red|amber|green|white) discussion( question)?( anonymously)? in? (?:the|a) (community|private group|secret group|space)$/ do |marking, question, anonymous, location|
  @subject = on(HomePage).create_title_for('discussion')
  @marking = marking
  @location = location

  Request.create_discussion @browser.cookies.to_a, @subject, question, "Lorem ipsumy goodness", @marking, Hash[:type => @location], "", anonymous
end

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
end

Then /^my inbox shows I have been mentioned( anonymously)?$/ do |anonymously|
  @browser.link(:href => "/inbox").when_present.click
  @browser.span(:class => 'title').when_present.click

  attempt = 0
  begin
    @browser.html.include? @subject
    if (anonymously)
      fail "Author visible" unless @browser.divs(:class => "j-author-act font-color-meta-light", :text => "Anonymous")
    end
  rescue
    attempt += 1
    if attempt <= 3 # Retry up to 3 times.
      @browser.refresh
      retry
    end
    fail 'IR not visible'
  end
end

Given /^I have created? (?:a|an) (red|amber|green|white) poll in? (?:the|a) (community|private group|secret group|space)$/ do |marking, location|
  @subject = on(HomePage).create_title_for('poll')
  @marking = marking
  @location = location
  on(HomePage).create('poll')
  on(PollPage).set_ihm_level(@marking)
  on(PollPage).set_publish_level(@location)
  on(PollPage).complete_poll :subject => @subject
  on(PollSummaryPage).verify_content_exists(@subject)
  on(PollSummaryPage).correct_ihm_displayed(@marking)
end

Then /^I can view the( anonymous)? discussion$/ do |anonymous|
  on(HomePage).click_content
  on(ContentPage).navigate_to_discussion_named(@subject)
  on(DiscussionSummaryPage).verify_content_exists(@subject)
  if (anonymous)
    on(DiscussionSummaryPage).verify_anonymous_as_participant
  end
end

Given(/^I have created? (?:a|an) (red|amber|green|white) blog post in a private group$/) do |marking|
  @subject = on(HomePage).create_title_for('blog')
  @marking = marking
  on(HomePage).create('blog')
  on(BlogPostPage).set_ihm_level(@marking)
  on(BlogPostPage).publish_to(custom_group)
  on(BlogPostPage).complete_blog_post :subject => @subject
  on(BlogPostSummaryPage).verify_content_exists(@subject)
  on(BlogPostSummaryPage).correct_ihm_displayed(@marking)
end

Then /^I can edit the anonymous incident report$/ do
  visit IncidentReportEditPage, :using_params => {:id => @incident_id}
  on(IncidentReportEditPage).verify_page_title
  @new_subject = on(IncidentReportEditPage).change_subject
  on(IncidentReportSummaryPage).verify_content_exists(@new_subject)
end
