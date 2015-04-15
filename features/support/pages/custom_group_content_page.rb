require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class CustomGroupContentPage
  include PageObject
  include FigNewton
  include NavRibbon
  include UserModal

  page_url("#{FigNewton.base_url}/groups/#{FigNewton.custom_group}/content")
  
  link(:incident_report, :href => /create\-incidentreport\!input\.jspa\?containerType\=14&containerID\=\d+/)

  def create_incident_report
    @browser.link(:href => /create\-incidentreport\!input\.jspa\?containerType\=14&containerID\=\d+/).wait_until_present
    incident_report
  end

  def verify_ir_exists_with(title)
    fail 'Incident report not visible' unless @browser.html.include? title
  end

  def verify_ir_not_visible_with(title)
    fail 'Incident report visible' if @browser.html.include? title
  end
end
