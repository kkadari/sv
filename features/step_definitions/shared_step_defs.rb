Given /^I? (?:am|have) logged in as "([^\"]+)"$/ do |login|
  switch_user(login)
end

Given /^I have raised? (?:a|an) (red|amber|green|white) incident report( anonymously)? in? (?:the|a) (community|private group|secret group|space)$/ do |marking, anonymous, location|
  @subject = TitleCreator.create_title_for('incident')
  @marking = marking
  @location = location

  response = CreateContent.create_incident_report @browser.cookies.to_a, @subject, 'Lorem ipsumy goodness', @marking, Hash[:type => @location], "", anonymous
  @incident_id = response['redirect'][/[0-9]+/,0]
  @incident_url = UrlFactory.incidentreportsummaryparampage + response['redirect']
end

Then /^I? (?:can|have)? (?:comment|commented) on the incident report( anonymously)?$/ do |anonymous|
  if anonymous
    payload = CommentPayload.new('<body><p>A new comment</p></body>',true).payload
  else
    payload = CommentPayload.new('<body><p>A new comment</p></body>',false).payload
  end

  Comment.post_ir_comment(@incident_id, payload, @browser.cookies.to_a)
end

Given /^I have created? (?:a|an) (red|amber|green|white) discussion( question)?( anonymously)? in? (?:the|a) (community|private group|secret group|space)$/ do |marking, question, anonymous, location|
  @subject = TitleCreator.create_title_for('discussion')
  @marking = marking
  @location = location

  response = CreateContent.create_discussion @browser.cookies.to_a, @subject, question, 'Lorem ipsumy goodness', @marking, Hash[:type => @location], "", anonymous
  @discussion_id = response['redirect'][/[0-9]+/,0]
end

Then /^my inbox shows I have been mentioned( anonymously)?$/ do |anonymously|
  sleep(5) # We wait a few seconds to let Jive process the Inbox

  if anonymously
    response = Inbox.get_inbox(@browser.cookies.to_a)
    fail 'Author visible' unless Nokogiri::HTML.parse(response).css('.j-js-act-content > div > div').text.include? 'Anonymous mentioned you in ' + @subject
  end
end

Given /^I have created? (?:a|an) (red|amber|green|white) poll in? (?:the|a) (community|private group|secret group|space)$/ do |marking, location|
  @subject = TitleCreator.create_title_for('poll')
  @marking = marking

  payload = PollPayload.new(@browser.cookies.to_a, @subject, 'Test automation poll', marking, 'Auto choice ', {:type => location}).payload
  response = CreateContent.post_create_poll(payload, @browser.cookies.to_a)

  # This is clunky but will do for now - Review later MW
  @incident_id = response.headers[:redirect].gsub(ENV['base_url'],'')[/[0-9]+/,0]
end

Then /^I can locate and view the( anonymous)? discussion$/ do |anonymous|
  response = Content.get_message(@discussion_id, @browser.cookies.to_a)

  title = Nokogiri::HTML.parse(response).css('.js-original-header > h1').text
  fail 'Content not visible or created' unless title.include? @subject

  if anonymous
    anon = Nokogiri::HTML.parse(response).css('.guest').to_s
    fail 'Content not visible or created' unless anon.include? 'Anonymous'
  end
end

Then /^I can verify the anonymous identifiers have been added to the discussion$/ do
  response = Content.get_message(@discussion_id, @browser.cookies.to_a)

  title = Nokogiri::HTML.parse(response).css('.js-original-header > h1').text
  fail 'Content not visible or created' unless title.include? @subject

  anon = Nokogiri::HTML.parse(response).css('.anonymous-badge').to_s
  fail 'Content not visible or created' if anon.include? 'This content was posted anonymously by its author'
end

Given /^I have created? (?:a|an) (red|amber|green|white) blog post in a private group$/ do |marking|
  @subject = TitleCreator.create_title_for('blog')
  @marking = marking

  payload = BlogPayload
                .new(@subject,
                     'Content goes here',
                     @marking,
                     Hash[:type => 'private group'],
                     'test1, test2, test3').payload

  CreateContent.post_blog(payload, @browser.cookies.to_a)
end

Then /^I can edit the anonymous incident report$/ do
  visit_and_benchmark EditIncidentReportPage, :using_params => {:id => @incident_id}

  on EditDiscussionPage do |edit|
    edit.wait_until do
      @browser.title.include? 'Edit incident report'
    end
    @new_subject = '=Edited='.concat edit.subject
    edit.subject = @new_subject
    edit.save
  end

  on(IncidentReportSummaryPage).wait_until do
    on(IncidentReportSummaryPage).title_element.exists?
  end

  fail 'Content not visible or created' unless on(IncidentReportSummaryPage).title.include? @new_subject
end

Given /^I am viewing an uploaded document I have recently created$/ do
  switch_user('participant A')

  @subject = TitleCreator.create_title_for('incident')

  payload = DocumentPayload
                .new(@subject,
                     'body content here',
                     'red',
                     'test.jpg').payload

  response = CreateContent.post_document(payload, @browser.cookies.to_a)
  @doc_id = response.scan(/DOC-[0-9]*/)[0]

  Content.get_document(@doc_id, @browser.cookies.to_a)
end

######### SMOKE TEST #########

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