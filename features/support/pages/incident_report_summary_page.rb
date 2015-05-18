require_relative '../modules/nav_ribbon'

require_relative '../modules/pdf_export'
require_relative '../modules/ihm_bar'

class IncidentReportSummaryPage
  include PageObject
  include NavRibbon

  include DataMagic
  include PdfExport
  include IhmBar
  extend UrlFactory

  page_url(incidentreportsummarypage)

  link(:delete, :text => /Delete/)
  button(:confirm_delete, :id => 'deletebutton')
  link(:edit_ir_button, :text => /Edit/)
  image(:avatar, :class => 'jive-avatar anonymous-avatar')
  div(:first_comment, :class => 'jive-comment-container')
  h1(:title, :css => '.jive-incidentreport h1')

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

  def capture_incident_id
    @browser.url.to_s.match(/.*incidentreports\/(\d+).*/)
    incident_id = $1
    raise 'Incident ID not captured' unless incident_id =~ /^\d+$/
    incident_id
  end

end
