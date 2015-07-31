Then /^I can edit the discussion$/ do
  response = EditContent.get_edit_message(@discussion_id, @browser.cookies.to_a)

  @token = Nokogiri::HTML.parse(response).css('input[name="jive.token.content.discussion.edit"]')[0]['value']
  @thread = Nokogiri::HTML.parse(response).css('input[name="thread"]')[0]['value']
  current_user = TestConfig.return_profile('participant A')

  payload = EditDiscussionPayload.new(@token, @thread, @subject + ' - UPDATE', 'An updated discussion', current_user[:username], 'red', {:type => 'community'}).payload
  EditContent.put_edit_message(@thread, payload, @browser.cookies.to_a)
end

Then /^I can change the discussion marking$/ do
  response = EditContent.get_edit_message(@discussion_id, @browser.cookies.to_a)

  @token = Nokogiri::HTML.parse(response).css('input[name="jive.token.content.discussion.edit"]')[0]['value']
  @thread = Nokogiri::HTML.parse(response).css('input[name="thread"]')[0]['value']
  current_user = TestConfig.return_profile('participant A')

  payload = EditDiscussionPayload.new(@token, @thread, @subject + ' - UPDATE', 'An updated discussion', current_user[:username], 'red', {:type => 'community'}).payload
  EditContent.put_edit_message(@thread, payload, @browser.cookies.to_a)

  response2 = Content.get_message(@discussion_id, @browser.cookies.to_a)
  ihm = Nokogiri::HTML.parse(response2).css('.ihmbar').text.downcase

  fail 'Marking not visible or not updated' unless ihm.include? 'red'
end