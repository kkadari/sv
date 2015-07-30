Then /^I can locate and view the blog post$/ do
  response = Content.get_blog(@blog_url, @browser.cookies.to_a)
  title = Nokogiri::HTML.parse(response).css('.jive-content > header > h1').text

  fail 'Content not visible or created' unless title.include? @subject
end

When /^I submit a comment for the blog post$/ do
  response = Content.get_blog(@blog_url, @browser.cookies.to_a)
  @blog_id = Nokogiri::HTML.parse(response).css('input[name="blogPost"]')[0]['value']

  payload = CommentPayload.new('Comment here', true).payload
  Comment.post_blog_comment(@blog_id, payload, @browser.cookies.to_a)
end

Then /^the comment is posted to the blog post$/ do
  response = Comment.get_blog_comments(@blog_id, @browser.cookies.to_a)

  fail('Comment not added') unless response.include? 'Comment here'
end