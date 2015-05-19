Then /^I can delete the incident report$/ do
  visit ViewIncidentReportPage, :using_params => {:id => @incident_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject

  on IncidentReportSummaryPage do |report|
    report.delete
    report.wait_until do
      report.delete_confirm_element.exists?
    end
    report.confirm_delete
  end
end