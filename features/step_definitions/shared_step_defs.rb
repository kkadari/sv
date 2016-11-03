Given /^I? (?:am|have) logged in as "([^\"]+)"$/ do |login|
  switch_user(login)
end

Given /^I have raised? (?:a|an) (red|amber|green|white) incident report( anonymously)? in? (?:the|a) (community|private group|secret group|space)$/ do |marking, anonymous, location|
  @subject = TitleCreator.create_title_for('incident')
  @marking = marking
  @location = location

  payload = IncidentReportPayload.new(@subject, false, 'Lorem ipsumy goodness', @marking, {:type => @location}, '', anonymous).payload
  response = CreateContent.create_incident_report(payload, $authorisation)
  @incident_id = response['redirect'][/[0-9]+/,0].to_s
  @incident_url = UrlFactory.incidentreportsummaryparampage + response['redirect']
end

Then /^I? (?:can|have)? (?:comment|commented) on the incident report( anonymously)?$/ do |anonymous|
  if anonymous
    payload = CommentPayload.new('<body><p>A new comment</p></body>', false).payload
  else
    payload = CommentPayload.new('<body><p>A new comment</p></body>', true).payload
  end

  Comment.post_ir_comment(@incident_id, payload, $authorisation)
end

Given /^I have created? (?:a|an) (red|amber|green|white) discussion( question)?( anonymously)? in? (?:the|a) (community|private group|secret group|space)$/ do |marking, question, anonymous, location|
  @subject = TitleCreator.create_title_for('discussion')
  @marking = marking
  @location = location

  payload = DiscussionPayload.new(@subject, question, 'Lorem ipsumy goodness', @marking, {:type => @location}, '', anonymous).payload
  response = CreateContent.create_discussion(payload, $authorisation)
  @discussion_id = response['redirect'][/[0-9]+/,0]
end

Then /^my inbox shows I have been mentioned( anonymously)?$/ do |anonymously|
  5.times do |i|
    begin
      if anonymously
        response = Inbox.get_inbox($authorisation)
        fail 'Author visible' unless Nokogiri::HTML.parse(response).css('.j-js-act-content > div > div').text.include? 'Anonymous mentioned you in ' + @subject
      end
      break
    rescue => e
      if i < 5
        sleep(1)
      else
        fail(e)
      end
    end
  end
end

Given /^I have created? (?:a|an) (red|amber|green|white) poll in? (?:the|a) (community|private group|secret group|space)$/ do |marking, location|
  @subject = TitleCreator.create_title_for('poll')
  @marking = marking

  response1 = CreateContent.get_create_poll($authorisation)
  poll_id = Nokogiri::HTML.parse(response1).css('input[name="pollID"]')[0]['value']

  response2 = CreateContent.get_poll_choice(poll_id, $authorisation)
  choice = JSON.parse(response2)['id']

  payload = PollPayload
                .new($authorisation,
                     poll_id,
                     choice,
                     @subject,
                     'Test automation poll',
                     marking,
                     'Auto choice ',
                     {:type => location}).payload

  response = CreateContent.post_create_poll(payload, $authorisation)

  @poll_id = JSON.parse(response)['redirect'].scan(/polls\/[0-9]*/)[0].gsub('polls/','')
end

Then /^I can locate and view the( anonymous)? discussion$/ do |anonymous|
  response = Content.get_message(@discussion_id, $authorisation)

  title = Nokogiri::HTML.parse(response).css('.js-original-header > h1').text
  fail 'Content not visible or created' unless title.include? @subject

  if anonymous
    anon = Nokogiri::HTML.parse(response).css('.guest').to_s
    fail 'Content not visible or created' unless anon.include? 'Anonymous'
  end
end

Then /^I can verify the anonymous identifiers have been added to the discussion$/ do
  response = Content.get_message(@discussion_id, $authorisation)

  title = Nokogiri::HTML.parse(response).css('.js-original-header > h1').text
  fail 'Content not visible or created' unless title.include? @subject

  anon = Nokogiri::HTML.parse(response).css('.anonymous-badge').to_s
  fail 'Content not visible or created' if anon.include? 'This content was posted anonymously by its author'
end

Given /^I have created? (?:a|an) (red|amber|green|white) blog post in (a private group|my personal blog)$/ do |marking, publication|
  @subject = TitleCreator.create_title_for('blog')
  @marking = marking
  current_user = TestConfig.return_profile('participant A')
  payload = BlogPayload
                .new(@subject,
                     'Content goes here',
                     @marking,
                     'test1, test2, test3',
                     current_user[:username]).payload

  response = CreateContent.post_blog(payload, $authorisation)
  @blog_url = JSON.parse(response.body)['redirect']
end

Then /^I can edit the anonymous incident report$/ do
  5.times do |i|
    begin
      response = EditContent.get_edit_ir(@incident_id, $authorisation)
      token = Nokogiri::HTML.parse(response).css('input[name="jive.token.content.incidentReport.create"]')[0]['value']

      payload = EditIrPayload.new(token, @incident_id, '=edited= ' + @subject, 'Updated IR>', 'red', {:type => 'community'}).payload

      EditContent.put_edit_ir(@incident_id, payload, $authorisation)

      ir = Content.get_ir(@incident_id, $authorisation)
      title = Nokogiri::HTML.parse(ir).css('.jive-content > header > h1').text

      fail 'Content not updated' unless title.include? '=edited= ' + @subject
      break
    rescue => e
      if i < 5
        sleep(1)
      else
        fail(e)
      end
    end
  end
end

Given /^I am viewing an uploaded document I have recently created$/ do
  switch_user('participant A')

  @subject = TitleCreator.create_title_for('incident')

  payload = DocumentPayload
                .new(@subject,
                     'body content here',
                     'red',
                     'test.jpg').payload

  response = CreateContent.post_document(payload, $authorisation)
  @doc_id = response.scan(/DOC-[0-9]*/)[0]

  Content.get_document(@doc_id, $authorisation)
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

    search.wait_until do
      search.search_results
    end
    sleep(1)
    search.top_result
  end
end
