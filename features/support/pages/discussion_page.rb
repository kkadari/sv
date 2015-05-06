require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'
require_relative '../modules/ihm_bar'
require_relative '../modules/publish_bar'
require_relative '../modules/anonymity_bar'

class DiscussionPage
  include PageObject
  include FigNewton
  include NavRibbon
  include UserModal
  include DataMagic
  include IhmBar
  include PublishBar
  include AnonymityBar

  page_url(/#{FigNewton.base_url}\/discussion\/create\.jspa\?sr\=cmenu\&containerType=\d+&containerID\=\d+/)
  
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