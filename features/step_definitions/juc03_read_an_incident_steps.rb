Then /^I am able to view the marking$/ do
  visit ViewIncidentReportPage, :using_params => {:id => @incident_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(IncidentReportSummaryPage).ihm_bar.downcase.include? @marking
end

Then /^I can verify the anonymous identifiers have been added$/ do
  visit ViewIncidentReportPage, :using_params => {:id => @incident_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(IncidentReportSummaryPage).ihm_bar.downcase.include? @marking

  fail 'Incident report not anonymous' unless @browser.html.to_s.include? 'This content was posted anonymously by its author'
end

Then /^I can not directly access the incident report if I am not in that group$/ do
  visit ViewIncidentReportPage, :using_params => {:id => @incident_id}

  fail 'Person profile unexpectedly displayed' unless @browser.html.to_s.include? 'Not Found'
end

Then /^I can view the anonymous incident report$/ do
  visit ViewIncidentReportPage, :using_params => {:id => @incident_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
end

Then /^I as an admin can view the anonymous incident report$/ do
  visit ViewIncidentReportPage, :using_params => {:id => @incident_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject

  fail 'Incident report not anonymous' unless @browser.html.to_s.include? 'This content was posted anonymously by its author'
end

Then (/^I can search for the incident report by ID and view the incident report$/) do
  visit(HomePage)
  on(GlobalNav).verify_spotlight_search_result_exists_for_incident_id @incident_id, @subject
  on(GlobalNav).click_search_result @subject
  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
end

Then (/^I can not find the incident report in search if I am not in that group$/) do
  on(GlobalNav).search_for @incident_id
  fail 'Content should not be visible' if @browser.html.to_s.include? @subject
end

Then(/^I will be able to view my recently created report$/) do
  visit ViewIncidentReportPage, :using_params => {:id => @incident_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(IncidentReportSummaryPage).ihm_bar.downcase.include? @marking
end
