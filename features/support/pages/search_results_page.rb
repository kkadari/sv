require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'
require_relative '../modules/search_box'

class SearchResultsPage
  include PageObject
  include NavRibbon
  include UserModal
  include SearchBox
  extend UrlFactory

  page_url(searchresultpage)

  def click_top_result
    @browser.links(:class => 'j-search-result-value').first.when_present.click
  end

  def click_people
    @browser.link(:title => 'Search for People').when_present.click
  end

  def sort_last_modified_newest_first
    @browser.select(:id => 'sort').select_value('updatedDesc')
  end

  def click_incident_reports
    @browser.link(:title => 'Show Incident Reports').when_present.click
  end
end
