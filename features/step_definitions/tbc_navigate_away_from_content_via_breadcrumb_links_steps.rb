Given /^I have navigated away from a poll using the breadcrumb links$/ do
  @subject = on(HomePage).create_title_for('poll')
  visit(LoginPage).log_in TestConfig.user1_uname, TestConfig.user1_pswd
  on(HomePage).create('poll')

  on CreatePollPage do |create|
    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation poll'
    create.option1          = 'Option 1 to choose'
    create.option2          = 'Option 2 to choose'
    create.set_ihm_level    'amber'
    create.publish_to       TestConfig.custom_group
    create.save
  end

  on(PollSummaryPage).follow_breadcrumb
end

Then /I am able to view more polls in a related container$/ do
  fail 'Not on correct content page' unless @browser.url.include? "/groups/#{TestConfig.custom_group}/content?filterID=contentstatus[published]~objecttype~objecttype[poll]"
end
