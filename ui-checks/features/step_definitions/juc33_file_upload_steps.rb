Given /^I am viewing a recently uploaded document with a word document attachment$/ do
  switch_user('participant A')

  @subject = TitleCreator.create_title_for('incident')
  payload = DocumentPayload.new(@subject, 'body content here', 'red', 'test.docx').payload

  response = CreateContent.post_document(payload, $authorisation)
  @doc_id = response.scan(/DOC-[0-9]*/)[0]
end

When /^I update the uploaded document with a updated word document attachment$/ do
  payload = EditDocumentPayload.new(@doc_id, @subject, 'test-update.docx').payload

  EditContent.post_edit_document(@doc_id, payload, $authorisation)
end

Then /^the system validates the upload and updates the uploaded document$/ do
  response = Content.get_document(@doc_id, $authorisation)

  fail('Attached document not updated') unless Nokogiri::HTML.parse(response).css('.jive-wiki-body-file-info').text.include? 'test-update'
end

When /^I submit an updated metadata for the uploaded documents$/ do
  @new_subject = TitleCreator.create_title_for('incident')
  payload = EditDocumentPayload.new(@doc_id, @new_subject, 'test.docx').payload

  EditContent.post_edit_document(@doc_id, payload, $authorisation)
end

Then /^the uploaded document's metadata is updated$/ do
  response = Content.get_document(@doc_id, $authorisation)
  subject = Nokogiri::HTML.parse(response).css('.jive-content > header > h1').text

  fail('Document metadata not updated') unless subject == @new_subject
end

Given /^I am viewing an uploaded document with multiple versions$/ do
  switch_user('participant A')

  @subject = TitleCreator.create_title_for('incident')
  payload = DocumentPayload.new(@subject, 'body content here', 'red', 'test.docx').payload

  response = CreateContent.post_document(payload, $authorisation)
  @doc_id = response.scan(/DOC-[0-9]*/)[0]

  payload = EditDocumentPayload.new(@doc_id, @subject, 'test-update.docx').payload

  EditContent.post_edit_document(@doc_id, payload, $authorisation)
end

When /^I opt to revert the uploaded document back to a previous version$/ do
  DocumentVersion.post_switch_version(@doc_id, '1', $authorisation)
end

Then /^the previous version of the uploaded document is displayed$/ do
  response = Content.get_document(@doc_id, $authorisation)

  fail('Attached document not updated') unless Nokogiri::HTML.parse(response).css('.jive-wiki-body-file-info').text.include? 'test'
end
