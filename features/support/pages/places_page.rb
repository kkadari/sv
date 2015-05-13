require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class PlacesPage
  include PageObject
  include NavRibbon
  include UserModal
  extend UrlFactory

  page_url(placespage)

  link(:custom_group, :href => "/groups/#{TestConfig.custom_group}")

  def verify_cannot_create_place
    browser.goto UrlFactory.cannotcreateplacepage
    fail 'Not presented with Unauthorized page' unless @browser.div(:id => 'jive-body-intro-content').h1.text.include?('Unauthorized')
  end

  def view_custom_group
    @browser.link(:href => "/groups/#{TestConfig.custom_group}").wait_until_present
    custom_group
  end
end
