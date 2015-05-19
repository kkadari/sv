require_relative '../modules/nav_ribbon'

class SearchPage
  include PageObject
  include NavRibbon
  extend UrlFactory

  page_url(searchpage)
  
  text_field(:search_query, :id => 'j-search-input')
  button(:submit_search, :class => 'js-search-submit')

  span(:search_results,:class => 'j-search-result-title')
  link(:people, :title => 'Search for People')
  link(:show_incident_reports, :title => 'Show Incident Reports')

end
