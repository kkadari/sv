Given /^I have navigated away from a poll using the breadcrumb links$/ do
  @subject = on(HomePage).create_title_for('poll')
  visit(LoginPage).log_in
  on(HomePage).create('poll')
  on(PollPage).set_ihm_level('amber')
  on(PollPage).publish_to(custom_group)
  on(PollPage).complete_poll :subject => @subject
  on(PollSummaryPage).follow_breadcrumb
end

Then /I am able to view more polls in a related container$/ do
  fail "Not on correct content page" unless @browser.url.include? "/groups/#{custom_group}/content?filterID=contentstatus[published]~objecttype~objecttype[poll]"
end
