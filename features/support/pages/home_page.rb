class HomePage
  include PageObject
  extend UrlFactory

  page_url(homepage)

  text_field(:spotlight_search, :css => '#searchpopupanchor > input')
  ordered_list(:results_container, :css => 'ol[role="listbox"]')
  elements(:result, :li, :class => 'j-listitem  ')
end
