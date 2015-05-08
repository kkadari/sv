require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'
require_relative '../modules/ihm_bar'
require_relative '../modules/publish_bar'
require_relative '../modules/anonymity_bar'
require_relative '../modules/title_creator'

class IncidentReportPage
  include PageObject
  include FigNewton
  include NavRibbon
  include UserModal
  include DataMagic
  include IhmBar
  include PublishBar
  include AnonymityBar
  include TitleCreator

  page_url(/#{FigNewton.base_url}\/create-incidentreport\!input\.jspa\?containerType\=\d+\&containerID\=\d+/)
  
  text_field(:subject, :name => 'subject')
  text_area(:body, :class => 'usertext')
  text_field(:tags, :xpath => "//div[contains(@id,'jive-compose-tags-form')]//input[@type=\"text\"][1]")

  def complete_incident_report(data = {})
    @browser.link(:id => 'wysiwygtext_html').when_present.click
    populate_page_with data_for(:IncidentReportPage, data)
    @browser.button(:id => 'submitButton').when_present.click
  end
end
