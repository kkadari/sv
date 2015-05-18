require_relative '../modules/nav_ribbon'
require_relative '../modules/ihm_bar'
require_relative '../modules/anonymity_bar'

class DiscussionPage
  include PageObject
  include NavRibbon
  include DataMagic
  include IhmBar
  include AnonymityBar
  extend UrlFactory

  page_url(discussionpage)
  
  text_field(:subject, :name => 'subject')
  text_area(:body, :class => 'usertext')
  text_field(:tags, :xpath => "//div[contains(@id,'jive-compose-tags-form')]//input[@type=\"text\"][1]")
  button(:save, :id => 'submitButton')

  def complete_discussion(data = {})
    @browser.link(:id => 'wysiwygtext_html').when_present.click
    populate_page_with data_for(:DiscussionPage, data)
    @browser.button(:id => 'submitButton').when_present.click
  end
  
  def mark_as_question
    @browser.checkbox(:id => 'mq01').when_present.set
  end
end