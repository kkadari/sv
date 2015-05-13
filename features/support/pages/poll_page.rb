require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'
require_relative '../modules/ihm_bar'
require_relative '../modules/publish_bar'

class PollPage
  include PageObject
  include NavRibbon
  include UserModal
  include DataMagic
  include IhmBar
  include PublishBar
  extend UrlFactory

  page_url(pollpage)
  
  text_field(:subject, :name => 'subject')
  text_area(:body, :class => 'usertext')
  text_field(:tags, :xpath => "//div[contains(@id,'jive-compose-tags-form')]//input[@type=\"text\"][1]")
  text_field(:option1, :name => 'options[0].text')
  text_field(:option2, :name => 'options[1].text')
  button(:save, :id => 'submitButton')

  def complete_poll(data = {})
    @browser.link(:id => 'wysiwygtext_html').when_present.click
    populate_page_with data_for(:PollPage, data)
    @browser.button(:id => 'submitButton').when_present.click
  end
end
