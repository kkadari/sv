require_relative '../modules/nav_ribbon'
require_relative '../modules/create_modal'
require_relative '../modules/search_box'
require_relative '../modules/ihm_bar'

class DiscussionEditPage
  include PageObject
  include NavRibbon
  include CreateModal
  include SearchBox
  include IhmBar
  extend UrlFactory

  page_url(discussioneditpage)
  
  text_field(:subject, :id => 'subject')

  def change_body_content
    @browser.link(:id => 'wysiwygtext_html').when_present.click
    @browser.send_keys [:equals, :numpad1, :numpad2, :numpad3, :numpad4, :equals, :return]
    @browser.button(:id => 'submitButton').when_present.click
  end
  
  def change_handling_level
    @new_color = edit_handling_level
    @browser.button(:id => 'submitButton').when_present.click
    @new_color
  end
  
  def change_subject
    @browser.text_field(:id => 'subject').when_present.set("=Edited= ".concat(subject))
    @new_subject = @browser.text_field(:id => 'subject').value
    @browser.button(:id => 'submitButton').when_present.click
    @new_subject
  end
end