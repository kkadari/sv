require_relative '../modules/nav_ribbon'

require_relative '../modules/ihm_bar'
require_relative '../modules/anonymity_bar'
require_relative '../modules/title_creator'

class IncidentReportPage
  include PageObject
  include NavRibbon

  include DataMagic
  include IhmBar
  include AnonymityBar
  include TitleCreator
  extend UrlFactory

  page_url(incidentreportpage)
  
  text_field(:subject, :name => 'subject')
  text_area(:body, :class => 'usertext')
  text_field(:tags, :xpath => "//div[contains(@id,'jive-compose-tags-form')]//input[@type=\"text\"][1]")

  def complete_incident_report(data = {})
    @browser.link(:id => 'wysiwygtext_html').when_present.click
    populate_page_with data_for(:IncidentReportPage, data)
    @browser.button(:id => 'submitButton').when_present.click
  end
end
