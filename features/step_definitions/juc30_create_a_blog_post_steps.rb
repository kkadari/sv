Given(/^I have created? (?:a|an) (red|amber|green|white) blog post in my personal blog$/) do |marking|
  @subject = on(HomePage).create_title_for('blog')
  @marking = marking

  on(HomePage).create('blog')

  on CreateBlogPostPage do |create|
    create.subject  = @subject
    create.enable_html_mode
    create.body             = 'Test automation poll'
    create.set_ihm_level      @marking
    create.save
  end

  on(BlogPostSummaryPage).wait_until do
    on(BlogPostSummaryPage).title_element.exists?
  end

  on(BlogPostSummaryPage).ihm_bar.downcase.includes? @marking
end

Then(/^I can view the blog post$/) do
  visit(ContentPage)
  on(GlobalNav).content
  on(ContentPage).navigate_to_blog_post_named @subject
  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject

  on(BlogPostSummaryPage).ihm_bar.downcase.includes? @marking
end
