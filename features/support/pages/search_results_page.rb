class SearchResultsPage
  include PageObject
  extend UrlFactory

  page_url(searchresultpage)
  select(:sort, :id => 'sort')
  link(:top_result, :class => 'j-search-result-value')
end