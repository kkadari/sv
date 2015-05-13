Then /^I can delete the incident report$/ do
  visit ViewIncidentReportPage, :using_params => {:id => @incident_id}

  on(IncidentReportSummaryPage).verify_content_exists(@subject)
  on(IncidentReportSummaryPage).delete_incident_report
end