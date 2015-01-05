require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'
require_relative '../modules/search_box'

class SearchResultsPage
  include PageObject
  include NavRibbon
  include UserModal
  include SearchBox

  page_url("#{FigNewton.base_url}/search.jspa?q=#{/.*/}")

  def verify_content_exists(title)
    sleep 4 # allow time to render
    fail "Content not visible or created" unless @browser.html.to_s.include? title
  end

  def verify_content_not_exists(title)
    fail 'Content should not be visible' if @browser.html.to_s.include? title
  end

  def click_top_result
    @browser.links(:class => 'j-search-result-value').first.when_present.click
  end

  def verify_results_present_for(user)
    fail "User not visible" unless @browser.html.to_s.include? user
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
