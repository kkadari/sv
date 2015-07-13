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

When /^I opt to delete the uploaded document$/ do
  DeleteContent.delete_document(@doc_id, @browser.cookies.to_a)
end

Then /^the document is confirmed as deleted$/ do
  Content.get_document(@doc_id, @browser.cookies.to_a, 404)
end

Then /^can no longer be searched for$/ do
  response = Search.get_content_only_search(@doc_id, @browser.cookies.to_a)

  fail('Document ' + @doc_id + ' found in search') if JSON.parse(response.split(';',0)[1])['list'].length > 0
end