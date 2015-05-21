When(/^I find and click on a (.*?) I would like to access$/) do |type|
  case type
    when 'group'
      @object_type = 'groups'
    when 'space'
      @object_type = 'community'
    else
      fail 'I don\'t like the option: ' + type
  end

  visit AdvancedSearchPage do |search|
    search.show_places
    search.search_query = 'a*'
    search.submit_query

    search.all_results_elements.each do |result|
      if result.attribute('href').include? object_type
        result
        break
      end
    end
  end
end

Then /^the group is displayed to me$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the space is displayed to me$/ do
  pending # express the regexp above with the code you wish you had
end