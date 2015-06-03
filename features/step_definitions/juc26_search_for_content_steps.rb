Then /^I can use Jive search to find the anonymous incident report$/ do
  visit_and_benchmark AdvancedSearchPage do | search |
    search.search_query = @subject
    search.submit_search
    search.search_results_element.exists?
  end

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
end

Then /^I can use the spotlight search to find the incident report by ID$/ do
  on(GlobalNav).verify_spotlight_search_result_exists_for_incident_id(@incident_id, @subject)
end

Then /^I am not able to view their identity on the comment when I search for the incident report$/ do
  visit_and_benchmark AdvancedSearchPage do | search |
    search.wait_until do
      search.search_query = @subject
      search.submit_search
      search.search_results_element.exists?
    end

    search.show_incident_reports
    search.sort = 'Last modified: newest first'

    fail 'Content not visible or created' unless @browser.html.to_s.include? @subject

    search.top_result
  end

  !fail 'Not marked as anonymous' unless on(IncidentReportSummaryPage).avatar_element.exists?
  !fail 'Username visible' if on(IncidentReportSummaryPage).first_comment.include? @test_config_set[:user_1_name]
end

Given /^I have used spotlight search to search for a participant$/ do
  on(GlobalNav).verify_spotlight_search_result_exists @test_config_set[:user_2_name]
end

Then /^details for that participant are returned by Jive search$/ do
  fail 'User not visible' unless @browser.html.to_s.include? @test_config_set[:user_2_name]
end
