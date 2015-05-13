Then /^I am able to view the marking$/ do
  on(HomePage).click_content
  on(ContentPage).navigate_to_ir_named @subject
  on(IncidentReportSummaryPage).verify_content_exists @subject
  on(IncidentReportSummaryPage).correct_ihm_displayed @marking
end

Then /^I can verify the anonymous identifiers have been added$/ do
  on(HomePage).click_content
  on(ContentPage).navigate_to_ir_named @subject
  on(IncidentReportSummaryPage).verify_content_exists @subject
  on(IncidentReportSummaryPage).correct_ihm_displayed @marking
  on(IncidentReportSummaryPage).verify_anonymous
end

Then /^I can not directly access the incident report if I am not in that group$/ do
  on(IncidentReportSummaryPage).navigate_directly_to_ir_with_id @incident_id
  on(IncidentReportSummaryPage).verify_not_found
end

Then /^I can see the incident in my activity stream$/ do
  navigate_to(HomePage)
  on(HomePage).confirm_ir_present_with @subject
end

Then /^I can view the anonymous incident report$/ do
  on(IncidentReportSummaryPage).navigate_directly_to_ir_with_id @incident_id
  on(IncidentReportSummaryPage).verify_content_exists @subject
end

Then /^I as an admin can view the anonymous incident report$/ do
  on(IncidentReportSummaryPage).navigate_directly_to_ir_with_id @incident_id
  on(IncidentReportSummaryPage).verify_content_exists @subject
  on(IncidentReportSummaryPage).verify_anonymous
end

Then (/^I can search for the incident report by ID and view the incident report$/) do
  visit(HomePage)
  on(HomePage).verify_spotlight_search_result_exists_for_incident_id @incident_id, @subject
  on(HomePage).click_search_result @subject
  on(IncidentReportSummaryPage).verify_content_exists @subject
end

Then (/^I can not find the incident report in search if I am not in that group$/) do
  on(HomePage).search_for @incident_id
  on(SearchResultsPage).verify_content_not_exists @subject
end

Then(/^I will be able to view my recently created report$/) do
  on(IncidentReportSummaryPage).navigate_directly_to_ir_with_id @incident_id
  on(IncidentReportSummaryPage).verify_content_exists @subject
  on(IncidentReportSummaryPage).correct_ihm_displayed @marking
end
