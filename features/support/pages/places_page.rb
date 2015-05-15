require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class PlacesPage
  include PageObject
  include NavRibbon
  include UserModal
  extend UrlFactory

  page_url(placespage)

  link(:custom_group, :href => "/groups/#{TestConfig.custom_group}")
  div(:place_header, :css => '#jive-body-intro-content h1')

  def verify_cannot_create_place

  end

  def view_custom_group
    @browser.link(:href => "/groups/#{TestConfig.custom_group}").wait_until_present
    custom_group
  end
end
