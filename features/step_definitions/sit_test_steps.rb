title = {}

Given(/^I create all the content types$/) do
  attack = %w(DDoS phishing logic-bomb trojan).sample
  @ir_subject = on(HomePage).create_title_for('incident')
  title[:ir] = @ir_subject
  visit(LoginPage).log_in
  on(HomePage).create('incident_report')
  on(IncidentReportPage).set_ihm_level('red')
  on(IncidentReportPage).publish_to(TestConfig.custom_group)
  on(IncidentReportPage).complete_incident_report :subject => @ir_subject
  on(IncidentReportSummaryPage).click_home

  @subject = on(HomePage).create_title_for('poll')
  title[:po] = @subject
  on(HomePage).create('poll')
  on(PollPage).set_ihm_level('amber')
  on(PollPage).publish_to(TestConfig.custom_group)
  on(PollPage).complete_poll :subject => @subject

  on(PollSummaryPage).click_home

  @subject = on(HomePage).create_title_for('blog')
  title[:bp] = @subject
  on(HomePage).create('blog')
  on(BlogPostPage).set_ihm_level('green')
  on(BlogPostPage).complete_blog_post :subject => @subject
  on(BlogPostSummaryPage).click_home

  @subject = on(HomePage).create_title_for('discussion')
  title[:di] = @subject
  on(HomePage).create('discussion')
  on(DiscussionPage).set_ihm_level('white')
  on(DiscussionPage).publish_to(TestConfig.custom_group)
  on(DiscussionPage).complete_discussion :subject => @subject
  on(DiscussionSummaryPage).click_home
  on(DiscussionSummaryPage).log_out
end

Then(/^I can view all the created content types as another user$/) do
  visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd
  on(HomePage).click_content
  on(ContentPage).polls.click
  fail 'Poll not visible' unless @browser.html.include? title[:po]
  on(ContentPage).blogs.click
  fail 'Blog post not visible' unless @browser.html.include? title[:bp]
  on(ContentPage).discussions.click
  fail 'Discussion not visible' unless @browser.html.include? title[:di]
  on(ContentPage).incident_reports.click
  fail 'Incident Report not visible' unless @browser.html.include? title[:ir]
  on(ContentPage).log_out
end

Given(/^all the content types have been created$/) do
  title != {}
end

Then(/^I can search for all the content types as another user$/) do
  visit(LoginPage).log_in TestConfig.user2_uname, TestConfig.user2_pswd
  on(HomePage).search_for title[:bp]

  fail 'Content not visible or created' unless @browser.html.to_s.include? title[:bp]
  on(SearchResultsPage).search_for title[:po]
  fail 'Content not visible or created' unless @browser.html.to_s.include? title[:po]
  on(SearchResultsPage).search_for title[:di]
  fail 'Content not visible or created' unless @browser.html.to_s.include? title[:di]
  on(SearchResultsPage).log_out
end

When(/^I can edit all the content types as the author$/) do
  visit(LoginPage).log_in
  on(HomePage).click_content
  on(ContentPage).navigate_to_content_named title[:di]
  on(DiscussionSummaryPage).click_edit
  on(DiscussionEditPage).change_body_content
  on(DiscussionSummaryPage).click_home
  on(HomePage).click_content
  on(ContentPage).navigate_to_content_named title[:po]
  on(PollSummaryPage).edit_poll
  on(PollEditPage).change_body_content
  on(PollSummaryPage).click_home
  on(HomePage).click_content
  on(ContentPage).navigate_to_blog_post_named title[:bp]
  on(BlogPostSummaryPage).edit_blog_post
  on(BlogPostEditPage).change_body_content
  on(BlogPostSummaryPage).click_home
end

Then(/^I can delete all the content types as the author$/) do
  visit(LoginPage).log_in
  on(HomePage).navigate_to_content_named title[:di]
  on(DiscussionSummaryPage).delete_discussion
  on(DiscussionSummaryPage).click_home
  on(HomePage).navigate_to_content_named title[:po]
  on(PollSummaryPage).delete_poll
  on(PollSummaryPage).click_home
  on(HomePage).navigate_to_blog_post_named title[:bp]
  on(BlogPostSummaryPage).delete_blog_post
  on(PollSummaryPage).log_out
end

When(/^as an admin I can delete incident reports$/) do
  visit(LoginPage).log_in TestConfig.adminuser_uname, TestConfig.adminuser_pswd
  on(HomePage).click_content
  on(ContentPage).navigate_to_ir_named title[:ir]
  on(IncidentReportSummaryPage).delete_incident_report
  on(IncidentReportPage).log_out
end
