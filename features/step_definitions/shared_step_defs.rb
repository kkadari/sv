Given /^I? (?:am|have) logged in as "([^\"]+)"$/ do |login|
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers[login]
end

Given /^I have quickly raised? (?:a|an) (red|amber|green|white) incident report( anonymously)? in? (?:the|a) (community|private group|secret group|space)$/ do |marking, anonymous, location|
  @subject = TitleCreator.create_title_for('incident')
  @marking = marking
  @location = location

  response = Request.create_incident_report @browser.cookies.to_a, @subject, "Lorem ipsumy goodness", @marking, Hash[:type => @location], "", anonymous
  @incident_id = response['redirect'][/[0-9]+/,0]
  @incident_url = UrlFactory.incidentreportsummaryparampage + response['redirect']
end

Then /^I? (?:can|have)? (?:comment|commented) on the incident report( anonymously)?$/ do |anonymous|
  visit_and_benchmark ViewIncidentReportPage, :using_params => {:id => @incident_id}

  on ViewIncidentReportPage do |comment|
    comment.comment
    comment.enable_html_mode
    comment.comment_body = 'An anonymous incident report comment'
    comment.check_anonymous if anonymous
    comment.save
  end
end

Given /^I have created? (?:a|an) (red|amber|green|white) discussion( question)?( anonymously)? in? (?:the|a) (community|private group|secret group|space)$/ do |marking, question, anonymous, location|
  @subject = TitleCreator.create_title_for('discussion')
  @marking = marking
  @location = location.gsub(' ','_')

  visit_and_benchmark CreateDiscussionPage do | create |
    if @location != 'community'
      create.publish_to @test_config_set[@location.parameterize.to_sym]
    else
      create.select_community
    end

    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation discussion body'
    create.handling_elements.each do |colour|
      colour.click if colour.text.downcase.include? @marking
    end
    create.check_anonymous    if anonymous
    create.check_as_question  if question
    create.save
  end

  on(DiscussionSummaryPage).wait_until do
    on(DiscussionSummaryPage).title_element.exists?
  end

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(DiscussionSummaryPage).ihm_bar.downcase.include? @marking

  fail 'Discussion not anonymous' unless @browser.html.to_s.include? 'This content was posted anonymously by its author' if anonymous
end

Given /^I have quickly created? (?:a|an) (red|amber|green|white) discussion( question)?( anonymously)? in? (?:the|a) (community|private group|secret group|space)$/ do |marking, question, anonymous, location|
  @subject = TitleCreator.create_title_for('discussion')
  @marking = marking
  @location = location

  response = Request.create_discussion @browser.cookies.to_a, @subject, question, "Lorem ipsumy goodness", @marking, Hash[:type => @location], "", anonymous
  @discussion_id = response['redirect'][/[0-9]+/,0]
end

Given /^I have raised? (?:a|an) (red|amber|green|white) incident report( anonymously)? in? (?:the|a) (community|private group|secret group|space)$/ do |marking, anonymous, location|
  @subject = TitleCreator.create_title_for('incident')
  @marking = marking
  @location = location.gsub(' ','_')

  visit_and_benchmark CreateIncidentReportPage do |create|
    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation poll'
    create.handling_elements.each do |colour|
      colour.click if colour.text.downcase.include? @marking
    end
    create.publish_to         @location
    create.check_anonymous if anonymous
    create.save
  end

  on(IncidentReportSummaryPage).wait_until do
    on(IncidentReportSummaryPage).title_element.exists?
  end

  on(IncidentReportSummaryPage).title.include? @subject
  on(IncidentReportSummaryPage).ihm_bar.downcase.include? @marking

  @browser.url.to_s.match(/.*incidentreports\/(\d+).*/)
  incident_id = $1
  raise 'Incident ID not captured' unless incident_id =~ /^\d+$/
end

Then /^my inbox shows I have been mentioned( anonymously)?$/ do |anonymously|
  visit(InboxPage)

  attempt = 0
  begin
    @browser.html.include? @subject
    if anonymously
      fail 'Author visible' unless @browser.divs(:class => 'j-author-act font-color-meta-light', :text => 'Anonymous')
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
  @subject = TitleCreator.create_title_for('poll')
  @marking = marking
  @location = location.gsub(' ','_')

  visit_and_benchmark CreatePollPage do |create|
    if @location != 'community'
      create.publish_to @test_config_set[@location.to_sym]
    else
      create.select_community
    end

    create.subject
    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation poll'
    create.option1          = 'Option 1 to choose'
    create.option2          = 'Option 2 to choose'
    create.handling_elements.each do |colour|
      colour.click if colour.text.downcase.include? @marking
    end
    create.save
  end

  on(PollSummaryPage).wait_until do
    on(PollSummaryPage).title_element.exists?
  end

  on(PollSummaryPage).title.include? @subject
  on(PollSummaryPage).ihm_bar.downcase.include? @marking

  # This is clunky but will do for now - Review later MW
  @incident_id = @browser.url.gsub(ENV['base_url'],'')[/[0-9]+/,0]
end

Then /^I can locate and view the( anonymous)? discussion$/ do |anonymous|
  visit_and_benchmark DiscussionSummaryPage, :using_params => {:id => @discussion_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  if anonymous

    fail 'Discussion does not include Anonymous avatar' unless on(DiscussionSummaryPage).avatar_element.visible?
  end
end

Given(/^I have created? (?:a|an) (red|amber|green|white) blog post in a private group$/) do |marking|
  @subject = TitleCreator.create_title_for('blog')
  @marking = marking

  visit_and_benchmark CreateBlogPostPage do |create|
    create.publish_to         @test_config_set[:private_group]
    create.subject
    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation poll'
    create.handling_elements.each do |colour|
      colour.click if colour.text.downcase.include? @marking
    end
    create.save
  end

  on(BlogPostSummaryPage).wait_until do
    on(BlogPostSummaryPage).title_element.exists?
  end

  on(BlogPostSummaryPage).title.include? @subject
  on(BlogPostSummaryPage).ihm_bar.downcase.include? @marking
end

Then /^I can edit the anonymous incident report$/ do
  visit_and_benchmark EditIncidentReportPage, :using_params => {:id => @incident_id}

  fail 'IR edit page title incorrect, was: ' + @browser.title unless @browser.title.include? 'Edit incident report'

  on EditDiscussionPage do |edit|
    @new_subject = '=Edited='.concat edit.subject
    edit.subject = @new_subject
    edit.save
  end

  on(IncidentReportSummaryPage).wait_until do
    on(IncidentReportSummaryPage).title_element.exists?
  end

  fail 'Content not visible or created' unless on(IncidentReportSummaryPage).title.include? @new_subject
end

When /^I find and click on (?:a|an) ([^\"]+) I would like to read$/ do |doctype|
  visit_and_benchmark AdvancedSearchPage do |search|
    case doctype
      when 'incident report'
        search.show_incident_reports
      when 'poll'
        search.show_polls
      when 'uploaded document'
        search.show_documents
      when 'blog post'
        search.show_blogs
      when 'discussion'
        search.show_discussions
      else
        fail 'Unrecognised parameter: ' + doctype
    end
    search.search_query = 'a*'
    search.submit_search

    search.wait_until do
      search.search_container?
    end

    search.top_result
  end
end