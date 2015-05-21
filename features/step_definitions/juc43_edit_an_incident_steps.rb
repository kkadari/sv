Then /^I can change incident report marking$/ do
  visit EditIncidentReportPage, :using_params => {:id => @incident_id}
  fail 'IR edit page title incorrect, was: ' + @browser.title unless @browser.title.include? 'Edit incident report'

  on EditIncidentReportPage do |edit|
    edit.handling_elements.each do |colour|
      colour.click if colour.text.downcase.include? 'white'
    end
    edit.save
  end

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(IncidentReportSummaryPage).ihm_bar.downcase.include? 'white'
end