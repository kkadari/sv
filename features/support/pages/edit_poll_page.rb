require_relative '../modules/nav_ribbon'
require_relative '../modules/create_modal'
require_relative '../modules/search_box'

class EditPollPage
  include PageObject
  include NavRibbon
  include CreateModal
  include SearchBox
  extend UrlFactory

  page_url(polleditpage)

  def change_body_content
    @browser.link(:id => 'wysiwygtext_html').when_present.click
    @browser.send_keys [:equals, :numpad1, :numpad2, :numpad3, :numpad4, :equals, :return]
    @browser.button(:id => 'submitButton').when_present.click
  end

  def edit_subject(subject)
    @browser.text_field(:id => 'subject').set("=Edited= ".concat(subject))
    @browser.button(:id => 'submitButton').when_present.click
  end
end