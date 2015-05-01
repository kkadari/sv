require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class ContentPage
  include PageObject
  include FigNewton
  include NavRibbon
  include UserModal

  page_url("#{FigNewton.base_url}/content")
  
  link(:blogs, :text => /Blog Posts/)
  link(:documents, :text => /Documents/)
  link(:discussions, :text => /Discussions/)
  link(:polls, :text => /Polls/)
  link(:incident_reports, :text => /Incident Reports/)

  def click_blogs
    sleep 3
    blogs
    sleep 1
  end

  def click_documents
    sleep 3
    documents
    sleep 1
  end

  def click_discussions
    sleep 3
    discussions
    sleep 1
  end

  def click_polls
    sleep 3
    polls
    sleep 1
  end

  def click_incident_reports
    sleep 3
    incident_reports
    sleep 1
  end

  def verify_blog_post_exists_with(title)
    sleep 1
    fail 'Blog post not visible' unless @browser.html.include? title
  end

  def verify_document_exists_with(title)
    sleep 1
    fail 'Document not visible' unless @browser.html.include? title
  end

  def verify_discussion_exists_with(title)
    sleep 1
    fail 'Discussion not visible' unless @browser.html.include? title
  end

  def verify_poll_exists_with(title)
    sleep 1
    fail 'Poll not visible' unless @browser.html.include? title
  end

  def verify_ir_exists_with(title)
    sleep 1
    fail 'Incident Report not visible' unless @browser.html.include? title
  end

  def navigate_to_content_named(subject)
    search = subject[0..25]
    sleep 3
    @browser.link(:text, /#{search}/).when_present.click
  end

  def navigate_to_blog_post_named(subject)
    search = subject[0..25]
    blogs
    sleep 3
    @browser.link(:text, /#{search}/).when_present.click
  end

  def navigate_to_document_named(subject)
    search = subject[0..25]
    documents
    sleep 3
    @browser.link(:text, /#{search}/).when_present.click
  end

  def navigate_to_discussion_named(subject)
    search = subject[0..25]
    discussions
    sleep 3
    @browser.link(:text, /#{search}/).when_present.click
  end

  def navigate_to_poll_named(subject)
    search = subject[0..25]
    polls
    sleep 3
    @browser.link(:text, /#{search}/).when_present.click
  end

  def navigate_to_ir_named(subject)
    incident_reports
    sleep 3
    @browser.link(:text, /#{subject}/).when_present.click
    sleep 2
  end
end
