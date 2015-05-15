require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'
require_relative '../modules/pdf_export'
require_relative '../modules/ihm_bar'

class IncidentReportSummaryPage
  include PageObject
  include NavRibbon
  include UserModal
  include DataMagic
  include PdfExport
  include IhmBar
  extend UrlFactory

  page_url(incidentreportsummarypage)

  link(:delete, :text => /Delete/)
  button(:confirm_delete, :id => 'deletebutton')
  link(:edit_ir_button, :text => /Edit/)
  image(:avatar, :class => 'jive-avatar anonymous-avatar')
  divs(:comments, :class => 'jive-comment-container')

  def delete_incident_report
    delete
    wait_until do
      @browser.text.include? 'Are you sure'
    end
    confirm_delete
  end

  def click_edit
    @browser.link(:text => 'Edit').when_present.click
  end

  def confirm_first_comment_is_anonymous user_name

  end

  def capture_incident_id
    @browser.url.to_s.match(/.*incidentreports\/(\d+).*/)
    incident_id = $1
    raise 'Incident ID not captured' unless incident_id =~ /^\d+$/
    incident_id
  end

  def verify_not_found
    wait_until { @browser.html.to_s.include? 'Not Found' }
  end

  def verify_content_exists(title)
    wait_until { @browser.html.to_s.include? title }
    #Ratings widget causes delay in logout link being accessible. Wait for it to fully load. ~TD
    @browser.div(:class => 'jive-content-avgrating-score').wait_until_present
  end
end
