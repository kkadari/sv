class AdvancedSearchPage
  include PageObject
  extend UrlFactory

  page_url(advsearchpage)

  text_field(:search_query, :id => 'j-search-input')
  button(:submit_search, :class => 'js-search-submit')

  list_item(:search_container, :css => '.j-content-results > .j-search-result')
  span(:search_results,:class => 'j-search-result-title')
  link(:people, :title => 'Search for People')
  select(:sort, :id => 'sort')
  link(:show_places, :title => 'Search for Places')
  link(:show_blogs, :title => 'Show Blog posts')
  link(:show_documents, :title => 'Show Documents')
  link(:show_discussions, :title => 'Show Discussions')
  link(:show_polls, :title => 'Show Polls')
  link(:show_incident_reports, :title => 'Show Incident Reports')

  link(:top_result, :class => 'j-search-result-value')
  links(:all_result, :class => 'j-search-result')
  elements(:result, :div, :css => '.j-content-results .j-result-content')
end
