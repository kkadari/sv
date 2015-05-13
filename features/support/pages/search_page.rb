require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class SearchPage
  include PageObject
  include NavRibbon
  include UserModal
  extend UrlFactory

  page_url(searchpage)
  
  text_field(:search, :id => 'j-search-input')
  link(:people, :title => 'Search for People')
  link(:incident_reports, :title => 'Show Incident Reports')

  def click_people
    people
  end

  def click_incident_reports
    incident_reports
  end

  def verify_search_result_exists_and_click(term)
    attempt = 0
    begin
      @browser.text_field(:id, 'j-search-input').when_present.set(term)
      @browser.input(:class, 'js-search-submit').click

      wait_until do
        @browser.span(:class,'j-search-result-title').exists?
      end

      @browser.elements(:class,'j-search-result-title').each do |ele|
        stripped = ele.attribute_value("innerHTML").gsub(/<[a-z ="-\/]*>/,'')
        if stripped.include? term
          ele.click
          return
        end
      end

      raise 'Couldn\t find search result'
    rescue
      attempt += 1
      if attempt <= 3 # Retry up to 3 times.
        @browser.text_field(:id, 'j-search-input').when_present.set(term)
        @browser.input(:class, 'js-search-submit').click
        retry
      end
      raise "Search term '#{term}' not found"
    end
  end

  def search_for(term)
    @browser.text_field(:id, 'j-search-input').set term
    @browser.send_keys :return
  end

end
