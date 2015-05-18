Then (/^I can use Jive search to find the anonymous incident report$/) do
  visit(SearchPage)
  on(SearchPage).verify_search_result_exists_and_click @subject
  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
end

Then (/^I can use the spotlight search to find the incident report by ID$/) do
  visit(HomePage)

  on(HomePage).verify_spotlight_search_result_exists_for_incident_id(@incident_id, @subject)
end

Then /^I am not able to view their identity on the comment when I search for the incident report$/ do
  visit(SearchPage)
  on(SearchPage).search_for @subject
  on(SearchResultsPage).click_incident_reports
  on(SearchResultsPage).sort_last_modified_newest_first
  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(SearchResultsPage).click_top_result

  !fail 'Not marked as anonymous' unless on(IncidentReportSummaryPage).avatar_element.exists?
  !fail 'Username visible' if on(IncidentReportSummaryPage).first_comment.include? TestConfig.user1_uname
end

Given /^I have used spotlight search to search for a participant$/ do
  on(HomePage).verify_spotlight_search_result_exists(TestConfig.user2_uname)
  visit(SearchPage)
  on(SearchPage).search_for TestConfig.user2_uname
  on(SearchResultsPage).click_people
end

Then /^details for that participant are returned by Jive search$/ do
  fail 'User not visible' unless @browser.html.to_s.include? TestConfig.user2_uname
end
