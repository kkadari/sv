require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class SearchPage
  include PageObject
  include NavRibbon
  include UserModal

  page_url("#{FigNewton.base_url}/search")
  text_field(:search, :id => 'j-search-input')
  link(:people, :title => 'Search for People')
  link(:incident_reports, :title => 'Show Incident Reports')

  def click_people
    people
  end

  def click_incident_reports
    incident_reports
  end

  def search_for(term)
    @browser.text_field(:id, 'j-search-input').set term
    @browser.send_keys :return
  end

end
