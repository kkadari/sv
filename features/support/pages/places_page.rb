require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class PlacesPage
  include PageObject
  include FigNewton
  include NavRibbon
  include UserModal

  page_url("#{FigNewton.base_url}/places")

  link(:custom_group, :href => "/groups/#{FigNewton.custom_group}")

  def verify_cannot_create_place
    browser.goto "#{FigNewton.base_url}/edit-place.jspa?parentObjectID=1&parentObjectType=14&containerType=14"
    fail 'Not presented with Unauthorized page' unless @browser.div(:id => 'jive-body-intro-content').h1.text.include?('Unauthorized')
  end

  def view_custom_group
    @browser.link(:href => "/groups/#{FigNewton.custom_group}").wait_until_present
    custom_group
  end
end
