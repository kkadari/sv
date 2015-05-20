Given /^I have navigated away from a poll using the breadcrumb links$/ do
  @subject = TitleCreator.create_title_for('poll')
  visit LoginPage do |creds|
    creds.populate_page_with :username => TestConfig.user1_uname, :password => TestConfig.user1_pswd
    creds.submit
  end
  on(GlobalNav).click_to_create_type('poll')

  on CreatePollPage do |create|
    create.publish_to       TestConfig.custom_group
    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation poll'
    create.option1          = 'Option 1 to choose'
    create.option2          = 'Option 2 to choose'
    create.set_ihm_level    'amber'
    create.save
  end

  on(PollSummaryPage).wait_until do
    on(PollSummaryPage).title_element.exists?
  end

  on(PollSummaryPage).breadcrumb
end

Then /I am able to view more polls in a related container$/ do
  fail 'Not on correct content page' unless @browser.url.include? "/groups/#{TestConfig.custom_group}/content?filterID=contentstatus[published]~objecttype~objecttype[poll]"
end
