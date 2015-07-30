Then /^I? (?:can|have)? (?:comment|commented) on the discussion( anonymously)?$/ do |anonymous|
  visit_and_benchmark ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? @subject[0.23]
        link.click
        break
      end
    end
  end

  on ViewDiscussionPage do |comment|
    comment.wait_until do
      comment.title?
    end

    comment.reply
    comment.enable_html_mode
    comment.comment_body = 'A discussion comment'
    comment.anonymous if anonymous
    comment.save
  end
end

Then /^I can comment on the comment( anonymously)?$/ do |anonymous|
  visit_and_benchmark ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? @subject[0.23]
        link.click
        break
      end
    end
  end

  on ViewDiscussionPage do |comment|
    comment.wait_until do
      comment.title?
    end

    comment.reply
    comment.enable_html_mode
    comment.comment_body = 'Anonymous comment for discussion'
    comment.anonymous if anonymous
    comment.save
  end
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