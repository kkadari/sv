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
  text_field(:tags, :class => 'js-tag-input')
  text_field(:option1, :name => 'options[0].text')
  text_field(:option2, :name => 'options[1].text')
  link(:enable_html_mode, :id => 'wysiwygtext_html')
  button(:save, :id => 'submitButton')

  def complete_poll(data = {})
    self.enable_html_mode_element.when_present.click
    populate_page_with data_for(:PollPage, data)
    self.save_element.click
  end
end
