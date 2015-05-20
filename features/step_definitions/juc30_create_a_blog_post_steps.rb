Given(/^I have created? (?:a|an) (red|amber|green|white) blog post in my personal blog$/) do |marking|
  @subject = TitleCreator.create_title_for('blog')
  @marking = marking

  on(GlobalNav).create('blog')

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

  on(BlogPostSummaryPage).ihm_bar.downcase.include? @marking
end

Then(/^I can view the blog post$/) do
  visit ContentPage do |content|
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
