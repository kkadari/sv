class PlacesPage
  include PageObject

  extend UrlFactory
  page_url(placespage)

  div(:place_header, :css => '#jive-body-intro-content h1')
  link(:active_menu, :css => '.active_item > a')

end
