require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class ContentPage
  include PageObject
  include NavRibbon
  include UserModal
  extend UrlFactory

  page_url(contentpage)
  
  link(:blogs, :text => /Blog Posts/)
  link(:documents, :text => /Documents/)
  link(:discussions, :text => /Discussions/)
  link(:polls, :text => /Polls/)
  link(:incident_reports, :text => /Incident Reports/)

  def navigate_to_content_named(subject)
    search = subject[0..23]
    @browser.link(:text, /#{search}/).when_present.click
  end

  def navigate_to_blog_post_named(subject)
    search = subject[0..23]
    blogs
    @browser.link(:text, /#{search}/).when_present.click
  end

  def navigate_to_discussion_named(subject)
    search = subject[0..23]
    discussions
    @browser.link(:text, /#{search}/).when_present.click
  end

  def navigate_to_ir_named(subject)
    search = subject[0..23]
    incident_reports
    @browser.link(:text, /#{search}/).when_present.click
  end
end
