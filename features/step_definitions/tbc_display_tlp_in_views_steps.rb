When /^I run a search for content in the Spotlight search$/ do
  visit_and_benchmark AdvancedSearchPage

  on HomePage do |home|
    home.spotlight_search_element.click
    home.search_input = 'Lorem'

    home.wait_until do
      home.results_container?
    end
  end
end

Then /^all the spotlight results will have TLP pills that match their incident level$/ do
  on(HomePage).result_elements.each do |result|
    fail('TLP is missing from spotlight search') unless result.html.include? '<span class="ihm-pill'
  end
end

When /^I run an advanced search for content in the Spotlight search$/ do
  visit_and_benchmark AdvancedSearchPage do |search|
    search.search_query = 'Lorem'
    search.submit_search

    search.wait_until do
      search.search_container?
    end
  end
end

Then /^all the results will have TLP pills that match their incident level$/ do
  on(AdvancedSearchPage).result_elements.each do |result|
    fail('TLP is missing from advanced search') unless result.html.include? '<span class="ihm-pill'
  end
end

When /^I view an activity stream for recent content$/ do
  visit_and_benchmark ActivityPage
end

Then /^all the activity entries will have TLP pills that match their incident level$/ do
  on(ActivityPage).activity_elements.each do |entry|
    fail('TLP is missing from activity') unless entry.html.include? '<span class="ihm-pill'
  end
end

When /^I navigate to browse content$/ do
  visit_and_benchmark ContentPage
end

Then /^all the content entries will have TLP pills that match their incident level$/ do
  on(ContentPage).full_content_elements.each do |entry|
    fail('TLP is missing from content') unless entry.html.include? '<span class="ihm-browse'
  end
end
