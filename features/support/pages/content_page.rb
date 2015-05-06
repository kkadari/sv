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
    blogs
  end

  def click_documents
    documents
  end

  def click_discussions
    discussions
  end

  def click_polls
    polls
  end

  def click_incident_reports
    incident_reports
  end

  def verify_blog_post_exists_with(title)
    fail 'Blog post not visible' unless @browser.html.include? title
  end

  def verify_document_exists_with(title)
    fail 'Document not visible' unless @browser.html.include? title
  end

  def verify_discussion_exists_with(title)
    fail 'Discussion not visible' unless @browser.html.include? title
  end

  def verify_poll_exists_with(title)
    fail 'Poll not visible' unless @browser.html.include? title
  end

  def verify_ir_exists_with(title)
    fail 'Incident Report not visible' unless @browser.html.include? title
  end

  def navigate_to_content_named(subject)
    search = subject[0..25]
    @browser.link(:text, /#{search}/).when_present.click
  end

  def navigate_to_blog_post_named(subject)
    search = subject[0..25]
    blogs
    @browser.link(:text, /#{search}/).when_present.click
  end

  def navigate_to_document_named(subject)
    search = subject[0..25]
    documents
    @browser.link(:text, /#{search}/).when_present.click
  end

  def navigate_to_discussion_named(subject)
    search = subject[0..25]
    discussions
    @browser.link(:text, /#{search}/).when_present.click
  end

  def navigate_to_poll_named(subject)
    search = subject[0..23]
    polls
    @browser.link(:text, /#{search}/).when_present.click
  end

  def navigate_to_ir_named(subject)
    search = subject[0..25]
    incident_reports
    @browser.link(:text, /#{search}/).when_present.click
  end
end
