Given(/^I have created? (?:a|an) (red|amber|green|white) blog post in my personal blog$/) do |marking|
  @subject = on(HomePage).create_title_for('blog')
  @marking = marking
  on(HomePage).create('blog')
  on(BlogPostPage).set_ihm_level(@marking)
  on(BlogPostPage).complete_blog_post :subject => @subject
  on(BlogPostSummaryPage).verify_content_exists @subject
  on(BlogPostSummaryPage).correct_ihm_displayed @marking
end

Then(/^I can view the blog post$/) do
  visit(ContentPage)
  on(ContentPage).navigate_to_blog_post_named @subject
  on(BlogPostSummaryPage).verify_content_exists @subject
  on(BlogPostSummaryPage).correct_ihm_displayed @marking
end
