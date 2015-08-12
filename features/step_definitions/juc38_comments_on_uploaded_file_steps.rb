When /^I submit a comment for the uploaded document$/ do
  @id = @doc_id.split('-')[1]
  payload = CommentPayload.new('Auto comment for document',true).payload

  Comment.post_document_comment(@id, payload, @browser.cookies.to_a)
end

Then /^the comment is submitted successfully and displayed under the uploaded file$/ do
  response = Comment.get_document_comments(@id, @browser.cookies.to_a)

  fail('Comment not found in document') unless Nokogiri::HTML.parse(response).css('.jive-rendered-content').text.include? 'Auto comment for document'
end

Given /^I am viewing an uploaded document that has a comment$/ do
  switch_user('participant A')

  @subject = TitleCreator.create_title_for('incident')
  payload = DocumentPayload.new(@subject, 'body content here', 'red', 'test.jpg').payload

  response = CreateContent.post_document(payload, @browser.cookies.to_a)
  @doc_id = response.scan(/DOC-[0-9]*/)[0]
  @id = @doc_id.split('-')[1]

  payload = CommentPayload.new('Initial comment for document',true).payload
  Comment.post_document_comment(@id, payload, @browser.cookies.to_a)

  Content.get_document(@doc_id, @browser.cookies.to_a)
  @comment_response = Comment.get_document_comments(@id, @browser.cookies.to_a)
end

When /^I submit a comment on the original comment$/ do
  comment_id = Nokogiri::HTML.parse(@comment_response).css('.j-comment-footer > li')[0]['data-comment-id']

  payload = CommentPayload.new('Auto comment for document',true, comment_id).payload

  Comment.post_document_comment(@id, payload, @browser.cookies.to_a)
end

Given /^I am viewing an uploaded document that has multiple comments as "([^"]*)"$/ do |user|
  switch_user(user)

  @subject = TitleCreator.create_title_for('incident')
  payload = DocumentPayload.new(@subject, 'body content here', 'red', 'test.jpg').payload

  response = CreateContent.post_document(payload, @browser.cookies.to_a)
  @doc_id = response.scan(/DOC-[0-9]*/)[0]
  @id = @doc_id.split('-')[1]

  payload = CommentPayload.new('Initial comment for document',true).payload
  Comment.post_document_comment(@id, payload, @browser.cookies.to_a)

  Content.get_document(@doc_id, @browser.cookies.to_a)
  @comment_response = Comment.get_document_comments(@id, @browser.cookies.to_a)
end

When /^I mention "([^"]*)" in a comment on a comment$/ do |user|
  comment_id = Nokogiri::HTML.parse(@comment_response).css('.j-comment-footer > li')[0]['data-comment-id']

  user = TestConfig.return_profile(user)
  mention = '<a class=\'jive_macro jive_macro_user\' href=\'javascript:;\' jivemacro=\'user\' ___default_attr=\'' + user[:user_id] + '\' data-objecttype=\'3\' data-orig-content=\'' + user[:username] + '\'>' + user[:username] + '</a>'

  payload = CommentPayload.new('Auto mention comment for user2 ' + mention, true, comment_id).payload

  Comment.post_document_comment(@id, payload, @browser.cookies.to_a)
end

Then /^I will receive a notification that I have been mentioned in a comment$/ do
  5.times do |i|
    begin
      response = Inbox.get_inbox(@browser.cookies.to_a)

      notification = Nokogiri::HTML.parse(response).css('.j-act-unread')[0].text

      fail('Notification that you were mentioned was not found') unless notification.include? 'mentioned you in'
      fail('Notification is a mention but doesn\t match the subject created for this test') unless notification.include? @subject
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

Given /^I have mentioned "([^"]*)" on a uploaded document comment as "([^"]*)"$/ do |user1, user2|
  switch_user(user2)

  @subject = TitleCreator.create_title_for('incident')
  payload = DocumentPayload.new(@subject, 'body content here', 'red', 'test.jpg').payload

  response = CreateContent.post_document(payload, @browser.cookies.to_a)
  @doc_id = response.scan(/DOC-[0-9]*/)[0]
  @id = @doc_id.split('-')[1]

  user = TestConfig.return_profile(user1)
  mention = '<a class=\'jive_macro jive_macro_user\' href=\'javascript:;\' jivemacro=\'user\' ___default_attr=\'' + user[:user_id] + '\' data-objecttype=\'3\' data-orig-content=\'' + user[:username] + '\'>' + user[:username] + '</a>'

  payload = CommentPayload.new('Initial comment for document ' + mention,true).payload
  Comment.post_document_comment(@id, payload, @browser.cookies.to_a)

  Content.get_document(@doc_id, @browser.cookies.to_a)
  @comment_response = Comment.get_document_comments(@id, @browser.cookies.to_a)
end

When /^I additionally mention "([^"]*)" in the comment$/ do |user|
  comment_id = Nokogiri::HTML.parse(@comment_response).css('.j-comment-footer > li')[0]['data-comment-id']
  user = TestConfig.return_profile(user)

  mention = '<a class=\'jive_macro jive_macro_user\' href=\'javascript:;\' jivemacro=\'user\' ___default_attr=\'' + user[:user_id] + '\' data-objecttype=\'3\' data-orig-content=\'' + user[:username] + '\'>' + user[:username] + '</a>'
  payload = UpdateCommentPayload.new('Edited comment to now mention ' + mention).payload

  Comment.post_update_comment(comment_id, payload, @browser.cookies.to_a)
end
