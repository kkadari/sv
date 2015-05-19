require_relative '../modules/nav_ribbon'

class AdvancedSearchPage
  include PageObject
  include NavRibbon
  extend UrlFactory

  page_url(advsearchpage)
  
  text_field(:search_query, :id => 'j-search-input')
  button(:submit_search, :class => 'js-search-submit')

  span(:search_results,:class => 'j-search-result-title')
  link(:people, :title => 'Search for People')
  select(:sort, :id => 'sort')
  link(:show_incident_reports, :title => 'Show Incident Reports')

  link(:top_result, :class => 'j-search-result-value')

end
