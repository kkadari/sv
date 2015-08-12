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

  in_iframe(:class => 'htmlWidgetIframe') do |frame|
    div(:banner_container, :id => 'coin-slider-coin_articles', :frame => frame)
    div(:banner_title, :id => 'cs-title-coin_articles', :frame => frame)
    link(:banner_link, :class => 'cs-coin_articles', :frame => frame)
  end

  elements(:call_to_action, :div, :css => '.jive-html-text-widget .cta')
  div(:get_involved, :css => '.calls-to-action.vertical')

  list_item(:popular, :id => 'feed-popular')
  list_item(:following, :id => 'feed-following')
  div(:whats_happening, :id => 'whats-happening')
  list_item(:active_feed, :css => '.feeds .active')
  elements(:entry, :li, :css => '.newpost')
end
