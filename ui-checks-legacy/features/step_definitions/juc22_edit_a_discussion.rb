Then /^I can edit the discussion$/ do
  response = EditContent.get_edit_message(@discussion_id, $authorisation)
  token_name = Nokogiri::HTML.parse(response).css('input[name="jive.token.name"]')[0]['value']

  @token = Nokogiri::HTML.parse(response).css('input[name="'+token_name+'"]')[0]['value']
  @thread = Nokogiri::HTML.parse(response).css('input[name="thread"]')[0]['value']
  current_user = TestConfig.return_profile('participant A')

  payload = EditDiscussionPayload.new(@token, @thread, @subject + ' - UPDATE', 'An updated discussion', current_user[:username], 'red', {:type => 'community'}).payload
  EditContent.put_edit_message(@thread, payload, $authorisation)
end

Then /^I can change the discussion marking$/ do
  response = EditContent.get_edit_message(@discussion_id, $authorisation)
  token_name = Nokogiri::HTML.parse(response).css('input[name="jive.token.name"]')[0]['value']

  @token = Nokogiri::HTML.parse(response).css('input[name="'+token_name+'"]')[0]['value']
  @thread = Nokogiri::HTML.parse(response).css('input[name="thread"]')[0]['value']
  current_user = TestConfig.return_profile('participant A')

  payload = EditDiscussionPayload.new(@token, @thread, @subject + ' - UPDATE', 'An updated discussion', current_user[:username], 'red', {:type => 'community'}).payload
  EditContent.put_edit_message(@thread, payload, $authorisation)

  response2 = Content.get_message(@discussion_id, $authorisation)
  ihm = Nokogiri::HTML.parse(response2).css('.ihmbar').text.downcase

  fail 'Marking not visible or not updated' unless ihm.include? 'red'
end
