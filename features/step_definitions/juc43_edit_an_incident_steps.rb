Then /^I can change incident report marking$/ do
  visit EditIncidentReportPage, :using_params => {:id => @incident_id}
  fail 'IR edit page title incorrect, was: ' + @browser.title unless @browser.title.include? 'Edit incident report'

  on EditIncidentReportPage do |edit|
    @new_color = edit.edit_handling_level
    edit.save
  end

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(IncidentReportSummaryPage).ihm_bar.downcase.include? @marking
end