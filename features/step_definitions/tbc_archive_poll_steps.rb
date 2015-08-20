And /^I archive the poll$/ do
  Archive.post_archive_poll(@poll_id, $authorisation)

  poll = Content.get_poll(@poll_id, $authorisation)
  archive = Nokogiri::HTML.parse(poll).css('#j-poll-ended').text

  fail 'Poll not archived' unless archive.include? 'This poll was archived on'
end

Then /^I can edit the poll and it remain archived$/ do
  response1 = EditContent.get_edit_poll(@poll_id, $authorisation)
  token = Nokogiri::HTML.parse(response1).css('input[name="jive.token.content.poll.edit"]')[0]['value']

  payload = EditPollPayload.new(token, @poll_id, '=edited= ' + @subject, 'Updated content', 'Updated choices').payload
  
  EditContent.put_edit_poll(@poll_id, payload, $authorisation)
end