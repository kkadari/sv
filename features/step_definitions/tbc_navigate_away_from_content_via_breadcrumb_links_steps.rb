Given /^I have navigated away from a poll using the breadcrumb links$/ do
  @subject = TitleCreator.create_title_for('poll')

  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant A']

  on(GlobalNav) do |menu|
    menu.open_create
    menu.wait_until do
      menu.create_menu?
    end
    menu.create_poll
  end

  on CreatePollPage do |create|
    create.publish_to       @test_config_set[:private_group]
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
    on(PollSummaryPage).title_element.exists?
  end

  on(PollSummaryPage).breadcrumb
end

Then /I am able to view more polls in a related container$/ do
  fail 'Not on correct content page' unless @browser.url.include? "/groups/#{@test_config_set[:private_group]}/content?filterID=contentstatus[published]~objecttype~objecttype[poll]"
end
