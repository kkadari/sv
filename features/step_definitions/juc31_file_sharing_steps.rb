When /^I attempt to create an uploaded document with a word document attachment$/ do
  @subject = TitleCreator.create_title_for('incident')
  payload = DocumentPayload.new(@subject, 'body content here', 'red', 'test.docx').payload

  @response = CreateContent.post_document(payload, $authorisation)
end

Then /^the system validates the upload and creates the uploaded document$/ do
  fail('System did not return a 200') unless @response.code == 200
  @doc_id = @response.scan(/DOC-[0-9]*/)[0]
end

Then /^I can then preview the uploaded document$/ do
  Content.get_document(@doc_id, $authorisation)
end