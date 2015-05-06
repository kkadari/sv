Then (/^I can use Jive search to find the anonymous incident report$/) do
  navigate_to(HomePage)
  on(HomePage).verify_spotlight_search_result_exists_and_click @subject
  on(IncidentReportSummaryPage).verify_content_exists @subject
end

Then (/^I can use the spotlight search to find the incident report by ID$/) do
  navigate_to(HomePage)
  sleep 10 # allow time for IR to be indexed
  on(HomePage).verify_spotlight_search_result_exists_for_incident_id(@incident_id, @subject)
end

Then (/^I am not able to view their identity on the comment when I search for the incident report$/) do
  visit(SearchPage)
  on(SearchPage).search_for @subject
  on(SearchResultsPage).click_incident_reports
  on(SearchResultsPage).sort_last_modified_newest_first
  on(SearchResultsPage).verify_content_exists @subject
  on(SearchResultsPage).click_top_result
  on(IncidentReportSummaryPage).confirm_first_comment_is_anonymous user1_uname
end

Given /^I have used spotlight search to search for a participant$/ do
  on(HomePage).verify_spotlight_search_result_exists(user2_uname)
  visit(SearchPage)
  on(SearchPage).search_for user2_uname
  on(SearchResultsPage).click_people
end

Then /^details for that participant are returned by Jive search$/ do
  on(SearchResultsPage).verify_results_present_for(user2_uname)
end
