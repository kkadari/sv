Then /^I can locate and view the blog post$/ do
  response = Content.get_blog(@blog_url, $authorisation)
  title = Nokogiri::HTML.parse(response).css('.jive-blog-post-subject-header > div > h1').text

  fail 'Content not visible or created' unless title.include? @subject
end

When /^I submit a comment for the blog post$/ do
  response = Content.get_blog(@blog_url, $authorisation)
  @blog_id = Nokogiri::HTML.parse(response).css('input[name="blogPost"]')[0]['value']

  payload = CommentPayload.new('Comment here', true).payload
  response = Comment.post_blog_comment(@blog_id, payload, $authorisation)
  @comment_id = JSON.parse(response)['commentID'].to_s
end

Then /^the comment is posted to the blog post$/ do
  5.times do |i|
    begin
      response = Comment.get_blog_comments(@blog_id, $authorisation)

      fail('Comment not added') unless response.include? 'Comment here'
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

When /^I can like the comment$/ do
  payload = 'ratingType=like&voteValue=1'
  Comment.post_like('105', @comment_id, payload, $authorisation)
end

When /^I can unlike the comment$/ do
  payload = 'ratingType=like'
  Comment.post_unlike('105', @comment_id, payload, $authorisation)
end