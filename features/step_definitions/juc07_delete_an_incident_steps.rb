Then /^I can delete the incident report$/ do
  visit ViewIncidentReportPage, :using_params => {:id => @incident_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(IncidentReportSummaryPage).delete_incident_report
end