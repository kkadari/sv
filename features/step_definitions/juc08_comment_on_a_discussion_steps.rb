Then /^I? (?:can|have)? (?:comment|commented) on the discussion( anonymously)?$/ do |anonymous|
  response = Content.get_message(@discussion_id, @browser.cookies.to_a)
  thread_id = Nokogiri::HTML.parse(response).css('input[name="jive.token.name"]')[0]['value'].gsub('message.post.','')

  payload = MessageCommentPayload.new(thread_id, @discussion_id, @subject, 'Auto test comment', anonymous).payload

  Comment.post_message_comment(thread_id, @discussion_id, payload, @browser.cookies.to_a)
end

Then /^I can comment on the comment( anonymously)?$/ do |anonymous|
  response = Content.get_message(@discussion_id, @browser.cookies.to_a)
  thread_id = Nokogiri::HTML.parse(response).css('input[name="jive.token.name"]')[0]['value'].gsub('message.post.','')
  comment_id = Nokogiri::HTML.parse(response).css('.reply')[0]['data-object-id']

  payload = MessageCommentPayload.new(thread_id, comment_id, @subject, 'Auto test comment for comment', anonymous).payload

  Comment.post_message_comment(thread_id, comment_id, payload, @browser.cookies.to_a)
end

Given /^I have opted to leave a comment on a discussion as "([^"]*)" using the advanced editor$/ do |user|
  switch_user(user)
  subject = TitleCreator.create_title_for('discussion')

  payload = DiscussionPayload.new(subject, false, 'Lorem ipsumy goodness', 'green', {:type => 'community'}, '', false).payload
  response = CreateContent.create_discussion(payload, @browser.cookies.to_a)
  @discussion_id = response['redirect'][/[0-9]+/,0]

  Comment.get_advanced_comment_editor(@discussion_id, @browser.cookies.to_a)
end

When /^I submit a comment with some content$/ do
  payload = AdvancedCommentPayload.new(@discussion_id,'Posting advanced comment',false).payload

  Comment.post_advanced_comment_editor(payload, @browser.cookies.to_a)
end

Then /^the comment is published successfully$/ do
  response = Content.get_message(@discussion_id, @browser.cookies.to_a)

  comments = Nokogiri::HTML.parse(response).css('.jive-discussion-replies .jive-rendered-content')[0].text
  fail('Comment not found') unless comments.include? 'Posting advanced comment'
end