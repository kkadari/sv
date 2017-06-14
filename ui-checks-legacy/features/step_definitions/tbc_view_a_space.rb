When /^I find and click on a (.*?) I would like to access$/ do |type|
  case type
    when 'group'
      @object_type = 'groups'
    when 'space'
      @object_type = 'community'
    else
      fail 'I don\'t like the option: ' + type
  end

  visit_and_benchmark AdvancedSearchPage do |search|
    search.show_places
    search.search_query = 'a*'
    search.submit_search

    search.all_result_elements.each do |result|
      if result.attribute('href').include? object_type
        result
        break
      end
    end
  end
end

Then /^the group is displayed to me$/ do
  fail('Activity not displayed') if on(ViewGroupPage).activity_stream?
  fail('Space thumbnail not displayed') if on(ViewGroupPage).place_image?
end

Then /^the space is displayed to me$/ do
  fail('Activity not displayed') if on(ViewSpacePage).activity_stream?
  fail('Space thumbnail not displayed') if on(ViewSpacePage).place_image?
  fail('Subspace option not displayer') if on(ViewSpacePage).subspace?
end
