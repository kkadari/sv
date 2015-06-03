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
