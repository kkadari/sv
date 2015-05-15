Then (/^I can change incident report marking$/) do
  visit IncidentReportEditPage, :using_params => {:id => @incident_id}
  fail 'IR edit page title incorrect, was: ' + @browser.title unless @browser.title.include? 'Edit incident report'
  @new_color = on(IncidentReportEditPage).change_handling_level
  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(IncidentReportSummaryPage).correct_ihm_displayed(@new_color)
end