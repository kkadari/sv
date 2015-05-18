Given(/^I have created? (?:a|an) (red|amber|green|white) blog post in my personal blog$/) do |marking|
  @subject = on(HomePage).create_title_for('blog')
  @marking = marking
  on(HomePage).create('blog')
  on(BlogPostPage).set_ihm_level(@marking)
  on(BlogPostPage).complete_blog_post :subject => @subject

  on(BlogPostSummaryPage).wait_until do
    on(BlogPostSummaryPage).title_element.exists?
  end

  on(BlogPostSummaryPage).correct_ihm_displayed @marking
end

Then(/^I can view the blog post$/) do
  visit(ContentPage)
  on(ContentPage).navigate_to_blog_post_named @subject
  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(BlogPostSummaryPage).correct_ihm_displayed @marking
end
