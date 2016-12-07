class HomePage
  include PageObject
  extend UrlFactory

  page_url(homepage)

  list_item(:spotlight_search, :id => 'j-nav-search-li')
  text_field(:search_input, :id => 'j-visor-search-input')
  unordered_list(:results_container, :css => 'ul[role="listbox"]')
  elements(:result, :li, :class => 'j-listitem  ')
  link(:content, :id => 'customBrowseMenuAnchor')
  link(:members, :id => 'customMembersMenuAnchor')
  link(:places, :id => 'navCommunitiesAndNodes')
  elements(:menu_item, :li, :css => '.js-pop #myPlaces-list li')
  link(:colleagues, :text => 'Colleagues')
  link(:view_more, :text => 'view more')
  div(:footer, :class => 'footer-main')

  in_iframe(:class => 'htmlWidgetIframe') do |frame|
    div(:banner_container, :id => 'coin-slider-coin_articles', :frame => frame)
    div(:banner_title, :id => 'cs-title-coin_articles', :frame => frame)
    link(:banner_link, :class => 'cs-coin_articles', :frame => frame)
  end

  elements(:call_to_action, :div, :css => '.calls-to-action.horizontal .cta')
  div(:get_involved, :css => '.calls-to-action.vertical')

  list_item(:popular, :id => 'feed-popular')
  list_item(:following, :id => 'feed-following')
  div(:whats_happening, :id => 'whats-happening')
  list_item(:active_feed, :css => '.feeds .active')
  elements(:entry, :div, :css => '#whats-happening > .event-content')
end
