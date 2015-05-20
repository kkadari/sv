title = {}

Given(/^I create all the content types$/) do
  @ir_subject = TitleCreator.create_title_for('incident')
  title[:ir] = @ir_subject
  visit LoginPage do |creds|
    creds.populate_page_with :username => TestConfig.user1_uname, :password => TestConfig.user1_pswd
    creds.submit
  end
  on(GlobalNav).verify_cannot_create('incident_report')

  on CreateIncidentReportPage do |create|
    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation poll'
    create.handling_elements.each do |colour|
      colour.click if colour.text.downcase.include? 'red'
    end
    create.publish_to         TestConfig.custom_group
    create.check_anonymous
    create.save
  end

  on(GlobalNav).home

  @subject = TitleCreator.create_title_for('poll')
  title[:po] = @subject
  on(GlobalNav).verify_cannot_create('poll')

  on CreatePollPage do |create|
    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation poll'
    create.option1          = 'Option 1 to choose'
    create.option2          = 'Option 2 to choose'
    create.handling_elements.each do |colour|
      colour.click if colour.text.downcase.include? @marking
    end
    create.publish_to       @location
    create.save
  end

  on(GlobalNav).home

  @subject = TitleCreator.create_title_for('blog')
  title[:bp] = @subject
  on(GlobalNav).verify_cannot_create('blog')

  on CreateBlogPostPage do |create|
    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation poll'
    create.handling_elements.each do |colour|
      colour.click if colour.text.downcase.include? 'green'
    end
    create.save
  end

  on(GlobalNav).home

  @subject = TitleCreator.create_title_for('discussion')
  title[:di] = @subject
  on(GlobalNav).verify_cannot_create('discussion')

  on CreateDiscussionPage do | create |
    create.subject          = @subject
    create.enable_html_mode
    create.body             = 'Test automation discussion body'
    create.handling_elements.each do |colour|
      colour.click if colour.text.downcase.include? 'white'
    end
    create.publish_to         TestConfig.custom_group
    create.save
  end

  on(GlobalNav).home
  visit(LogoutPage)
end

Then /^I can view all the created content types as another user$/ do
  visit LoginPage do |creds|
    creds.populate_page_with :username => TestConfig.user2_uname, :password => TestConfig.user2_pswd
    creds.submit
  end
  on(GlobalNav).content
  on(ContentPage).polls
  fail 'Poll not visible' unless @browser.html.include? title[:po]
  on(ContentPage).blogs
  fail 'Blog post not visible' unless @browser.html.include? title[:bp]
  on(ContentPage).discussions
  fail 'Discussion not visible' unless @browser.html.include? title[:di]
  on(ContentPage).incident_reports
  fail 'Incident Report not visible' unless @browser.html.include? title[:ir]
  visit(LogoutPage)
end

Given(/^all the content types have been created$/) do
  title != {}
end

Then(/^I can search for all the content types as another user$/) do
  visit LoginPage do |creds|
    creds.populate_page_with :username => TestConfig.user2_uname, :password => TestConfig.user2_pswd
    creds.submit
  end
  on(GlobalNav).search_for title[:bp]

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
  visit LoginPage do |creds|
    creds.populate_page_with :username => TestConfig.user1_uname, :password => TestConfig.user1_pswd
    creds.submit
  end

  visit ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? title[:di]
        link.click
        break
      end
    end
  end

  on(DiscussionSummaryPage).edit

  on EditDiscussionPage do |edit|
    edit.enable_html_mode
    edit.body = '=1234='
    edit.save
  end

  on(GlobalNav).home
  visit ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? title[:po]
        link.click
        break
      end
    end
  end
  on(PollSummaryPage).edit

  on EditPollPage do |edit|
    edit.enable_html_mode
    edit.body = '=1234='
    edit.save
  end

  on(GlobalNav).home
  visit ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? title[:bp]
        link.click
        break
      end
    end
  end
  on(BlogPostSummaryPage).edit

  on EditBlogPostPage do |edit|
    edit.enable_html_mode
    edit.body = '=1234='
    edit.save
  end

  on(GlobalNav).home
end

Then(/^I can delete all the content types as the author$/) do
  visit LoginPage do |creds|
    creds.populate_page_with :username => TestConfig.user1_uname, :password => TestConfig.user1_pswd
    creds.submit
  end
  visit ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? title[:di]
        link.click
        break
      end
    end
  end

  on DiscussionSummaryPage do |discussion|
      discussion.delete

      discussion.wait_until do
        discussion.delete_container_element.exists?
      end

      discussion.confirm_delete
  end

  on(GlobalNav).home
  visit ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? title[:po]
        link.click
        break
      end
    end
  end
  on PollSummaryPage do |poll|
    poll.delete

    poll.wait_until do
      poll.delete_confirmation_element.exists?
    end

    poll.confirm_deletion
  end
  on(GlobalNav).home
  on(GlobalNav).content
  visit ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? title[:bp]
        link.click
        break
      end
    end
  end

  on BlogPostSummaryPage do |blog|
    blog.delete
    blog.wait_until do
      blog.delete_container.exists?
    end
    blog.confirm_delete
  end

  visit(LogoutPage)
end

When /^as an admin I can delete incident reports$/ do
  visit LoginPage do |creds|
    creds.populate_page_with :username => TestConfig.adminuser_uname, :password => TestConfig.adminuser_pswd
    creds.submit
  end

  visit ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? title[:ir]
        link.click
        break
      end
    end
  end

  on IncidentReportSummaryPage do |report|
    report.delete
    report.wait_until do
      report.delete_confirm_element.exists?
    end
    report.confirm_delete
  end

  visit(LogoutPage)
end
