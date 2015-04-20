Then /^I can delete the incident report$/ do
  on(HomePage).navigate_to_ir_named(@subject)
  on(IncidentReportSummaryPage).verify_content_exists(@subject)
  on(IncidentReportSummaryPage).delete_incident_report
end