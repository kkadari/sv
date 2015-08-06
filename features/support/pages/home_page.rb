class HomePage
  include PageObject
  extend UrlFactory

  page_url(homepage)

  text_field(:spotlight_search, :css => '#searchpopupanchor > input')
  ordered_list(:results_container, :css => 'ol[role="listbox"]')
  elements(:result, :li, :class => 'j-listitem  ')
  link(:content, :id => 'cispBrowseMenuAnchor')
  link(:members, :id => 'cispMembersMenuAnchor')
  link(:places, :id => 'navCommunitiesAndNodes')
  elements(:menu_item, :li, :css => '.js-pop #myPlaces-list li')
  link(:colleagues, :text => 'Colleagues')
  link(:view_more, :text => 'view more...')

  div(:footer, :class => 'footer-main')
end
