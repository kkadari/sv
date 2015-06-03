Then /^I can change incident report marking$/ do
  visit_and_benchmark EditIncidentReportPage, :using_params => {:id => @incident_id} do |edit|
    fail 'IR edit page title incorrect, was: ' + @browser.title unless @browser.title.include? 'Edit incident report'
    edit.handling_elements.each do |colour|
      colour.click if colour.text.downcase.include? 'white'
    end
    edit.save
  end

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(IncidentReportSummaryPage).ihm_bar.downcase.include? 'white'
end