Given /^I am viewing an uploaded file as "([^"]*)"$/ do |user|
  switch_user(user)

  @subject = TitleCreator.create_title_for('incident')
  payload = DocumentPayload.new(@subject, 'body content here', 'red', 'test.jpg').payload

  response = CreateContent.post_document(payload, @browser.cookies.to_a)
  @doc_id = response.scan(/DOC-[0-9]*/)[0]
end

When /^I select to download the attached file$/ do
  response = Content.get_document(@doc_id, @browser.cookies.to_a)
  url = Nokogiri::HTML.parse(response).css('.jive-wiki-body-file-actions a')[1]['href']

  RestClient.get(ENV['base_url'] + url,:cookie => Request.create_cookie(@browser.cookies.to_a)){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 200

    @response = response
  }
end

Then /^the attached file is downloaded$/ do
  fail('Image not downloaded') unless @response.headers[:content_disposition].include? 'test.jpg'
end

Given /^there is an uploaded document that has been recently created$/ do
  switch_user('participant A')

  @subject = TitleCreator.create_title_for('incident')
  payload = DocumentPayload.new(@subject, 'body content here', 'red', 'test.jpg').payload

  response = CreateContent.post_document(payload, @browser.cookies.to_a)
  @doc_id = response.scan(/DOC-[0-9]*/)[0]
end

When /^I navigate to the uploaded document directly$/ do
  @response = Content.get_document(@doc_id, @browser.cookies.to_a)
end

Then /^I am returned the uploaded document$/ do
  img_html = Nokogiri::HTML.parse(@response).css('.jive-content-body img')[0]['src']

  fail('Image not found in document') unless img_html.include? 'test.jpg'
end

Given /^there is an uploaded document that has been recently created for a secret group$/ do
  switch_user('participant B')

  @subject = TitleCreator.create_title_for('incident')
  payload = DocumentPayload.new(@subject, 'body content here', 'red', 'test.jpg', {:location => 'place'}).payload

  response = CreateContent.post_document(payload, @browser.cookies.to_a)
  @doc_id = response.scan(/DOC-[0-9]*/)[0]
end

When /^I attempt to view the uploaded document with a user that is not a member of the secret group$/ do
  switch_user('participant A')

  @response = Content.get_document(@doc_id, @browser.cookies.to_a, 403)
end

Then /^I am returned a page informing me the document isn't available$/ do
  error = Nokogiri::HTML.parse(@response).css('.jive-error-box').text

  fail('Document is rendered instead of error') unless error.include? 'Access to this place or content is restricted. If you think this is a mistake, please contact your administrator or the person who directed you here.'
end