Then /^as an admin I can view the anonymous discussion$/ do
  switch_user('admin')

  response = Content.get_message(@discussion_id, @browser.cookies.to_a)

  title = Nokogiri::HTML.parse(response).css('.js-original-header > h1').text
  fail 'Content not visible or created' unless title.include? @subject
end

When /^I attempt to view a discussion that has recently been deleted$/ do
  switch_user('admin')

  payload = DiscussionPayload.new('Discussion for deletion', false, 'Lorem ipsumy goodness', 'amber', {:type => 'community'}, '', false).payload
  response = CreateContent.create_discussion(payload, @browser.cookies.to_a)
  @discussion_id = response['redirect'][/[0-9]+/,0]

  DeleteContent.delete_discussion(@discussion_id, @browser.cookies.to_a)
end

Then /^the system displays a 'Not Found' error message$/ do
  5.times do |i|
    begin
      switch_user('participant A')

      Content.get_message(@discussion_id, @browser.cookies.to_a, 404)
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

######## SMOKE TEST STEPS ########

Then /^I can view the discussion$/ do
  on(DiscussionSummaryPage).wait_until do
    on(DiscussionSummaryPage).title?
  end

  fail 'Title not visible' unless on(DiscussionSummaryPage).title?
  fail 'IHM not visible' unless on(DiscussionSummaryPage).ihm_bar?
  fail 'Body not visible' unless on(DiscussionSummaryPage).original_message?
  fail 'Comment not visible' unless on(ViewDiscussionPage).reply?
end