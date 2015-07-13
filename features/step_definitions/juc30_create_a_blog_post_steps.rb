Given(/^I have created? (?:a|an) (red|amber|green|white) blog post in my personal blog$/) do |marking|
  @subject = TitleCreator.create_title_for('blog')
  @marking = marking

  visit_and_benchmark CreateBlogPostPage do |create|
    create.subject  = @subject
    create.enable_html_mode
    create.body             = 'Test automation poll'
    create.handling_elements.each do |colour|
      colour.click if colour.text.downcase.include? @marking
    end
    create.save
  end

  on(BlogPostSummaryPage).wait_until do
    on(BlogPostSummaryPage).title_element.exists?
  end

  on(BlogPostSummaryPage).ihm_bar.downcase.include? @marking
end

Then /^I can locate and view the blog post$/ do
  visit_and_benchmark ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? @subject[0.23]
        link.click
        break
      end
    end
  end

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject

  on(BlogPostSummaryPage).ihm_bar.downcase.include? @marking
end

Given /^I have quickly created an amber blog post in a private group$/ do
  switch_user('participant A')

  payload = BlogPayload
                .new(TitleCreator.create_title_for('blog'),
                     'Content goes here',
                     'amber',
                     Hash[:type => 'private group'],
                     'test1, test2, test3').payload

  response = CreateContent.post_blog(payload, @browser.cookies.to_a)
  @blog_url = JSON.parse(response)['redirect']
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