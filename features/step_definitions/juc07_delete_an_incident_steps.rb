Then /^I can delete the incident report$/ do
  visit_and_benchmark ViewIncidentReportPage, :using_params => {:id => @incident_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject

  on IncidentReportSummaryPage do |report|
    report.delete
    report.wait_until do
      report.delete_confirm_element.exists?
    end

    sleep 1 # Wait one second to allow the popup animation to complete.  Otherwise phantom throws a wobbly
    report.confirm_delete
  end
end