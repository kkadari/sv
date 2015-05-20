title = {}

Given(/^I create all the content types$/) do
  @ir_subject = on(HomePage).create_title_for('incident')
  title[:ir] = @ir_subject
  visit(LoginPage).log_in
  on(HomePage).create('incident_report')

  on CreateIncidentReportPage do |create|
    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation poll'
    create.set_ihm_level      'red'
    create.publish_to         TestConfig.custom_group
    create.check_anonymous
    create.save
  end

  on(GlobalNave).home

  @subject = on(HomePage).create_title_for('poll')
  title[:po] = @subject
  on(HomePage).create('poll')

  on CreatePollPage do |create|
    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation poll'
    create.option1          = 'Option 1 to choose'
    create.option2          = 'Option 2 to choose'
    create.set_ihm_level    @marking
    create.publish_to       @location
    create.save
  end

  on(GlobalNav).home

  @subject = on(HomePage).create_title_for('blog')
  title[:bp] = @subject
  on(HomePage).create('blog')

  on CreateBlogPostPage do |create|
    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation poll'
    create.set_ihm_level      'green'
    create.save
  end

  on(GlobalNav).home

  @subject = on(HomePage).create_title_for('discussion')
  title[:di] = @subject
  on(HomePage).create('discussion')

  on CreateDiscussionPage do | create |
    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation discussion body'
    create.set_ihm_level      'white'
    create.publish_to         TestConfig.custom_group
    create.save
  end

  on(GlobalNav).home
  visit(LogoutPage)
end

Then(/^I can view all the created content types as another user$/) do
  visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd
  on(GlobalNav).content
  on(ContentPage).polls.click
  fail 'Poll not visible' unless @browser.html.include? title[:po]
  on(ContentPage).blogs.click
  fail 'Blog post not visible' unless @browser.html.include? title[:bp]
  on(ContentPage).discussions.click
  fail 'Discussion not visible' unless @browser.html.include? title[:di]
  on(ContentPage).incident_reports.click
  fail 'Incident Report not visible' unless @browser.html.include? title[:ir]
  visit(LogoutPage)
end

Given(/^all the content types have been created$/) do
  title != {}
end

Then(/^I can search for all the content types as another user$/) do
  visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd
  on(HomePage).search_for title[:bp]

  fail 'Content not visible or created' unless @browser.html.to_s.include? title[:bp]
  on(AdvancedSearchPage).search_query = title[:po]
  on(AdvancedSearchPage).search_query = :return
  fail 'Content not visible or created' unless @browser.html.to_s.include? title[:po]
  on(AdvancedSearchPage).search_query = title[:di]
  on(AdvancedSearchPage).search_query = :return
  fail 'Content not visible or created' unless @browser.html.to_s.include? title[:di]
  visit(LogoutPage)
end

When(/^I can edit all the content types as the author$/) do
  visit(LoginPage).log_in
  on(GlobalNav).content
  on(ContentPage).navigate_to_content_named title[:di]
  on(DiscussionSummaryPage).edit

  on EditDiscussionPage do |edit|
    edit.enable_html_mode
    edit.body = '=1234='
    edit.save
  end

  on(GlobalNav).home
  on(GlobalNav).content
  on(ContentPage).navigate_to_content_named title[:po]
  on(PollSummaryPage).edit

  on EditPollPage do |edit|
    edit.enable_html_mode
    edit.body = '=1234='
    edit.save
  end

  on(GlobalNav).home
  on(GlobalNav).content
  on(ContentPage).navigate_to_blog_post_named title[:bp]
  on(BlogPostSummaryPage).edit

  on EditBlogPostPage do |edit|
    edit.enable_html_mode
    edit.body = '=1234='
    edit.save
  end

  on(GlobalNav).home
end

Then(/^I can delete all the content types as the author$/) do
  visit(LoginPage).log_in
  on(HomePage).navigate_to_content_named title[:di]

  on DiscussionSummaryPage do |discussion|
      discussion.delete

      discussion.wait_until do
        discussion.delete_container_element.exists?
      end

      discussion.confirm_delete
  end

  on(GlobalNav).home
  on(HomePage).navigate_to_content_named title[:po]
  on PollSummaryPage do |poll|
    poll.delete

    poll.wait_until do
      poll.delete_confirmation_element.exists?
    end

    poll.confirm_deletion
  end
  on(GlobalNav).home
  on(GlobalNav).content
  on(HomePage).navigate_to_blog_post_named title[:bp]

  on BlogPostSummaryPage do |blog|
    blog.delete
    blog.wait_until do
      blog.delete_container.exists?
    end
    blog.confirm_delete
  end

  visit(LogoutPage)
end

When(/^as an admin I can delete incident reports$/) do
  visit(LoginPage).log_in TestConfig.adminuser_uname, TestConfig.adminuser_pswd
  on(GlobalNav).content
  on(ContentPage).navigate_to_ir_named title[:ir]

  on IncidentReportSummaryPage do |report|
    report.delete
    report.wait_until do
      report.delete_confirm_element.exists?
    end
    report.confirm_delete
  end

  visit(LogoutPage)
end
