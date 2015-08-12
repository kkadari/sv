Then /^I am displayed a banner containing an image, text and a link to a page$/ do
  visit_and_benchmark(HomePage) do |home|
    home.wait_until do
      home.banner_container?
    end

    fail('Banner not found') unless home.banner_title?
    fail('Banner not found') unless home.banner_link?
  end
end

Then /^I will see three call to action widgets$/ do
  visit_and_benchmark(HomePage) do |home|
    fail('One or more call to actions are missing') unless home.call_to_action_elements.length == 3
  end
end

Then /^a sidebar widget containing links under the titles Get Involved and How we can help$/ do
  visit_and_benchmark(HomePage) do |home|
    fail('Side panel is missing') unless home.get_involved?
  end
end

Then /^I will see the What's happening widget$/ do
  visit_and_benchmark(HomePage) do |home|
    fail('Whats happening is missing') unless home.whats_happening?
  end
end

Then /^it is defaulted to the 'All' view$/ do
  on(HomePage) do |home|
    fail('All view is not selected as default') unless home.active_feed == 'All'
  end
end

Then /^each of the entries contain a title, author and TLP pill$/ do
  on(HomePage) do |home|
    home.entry_elements.each do |e|
      fail('Title missing') unless e.text.match(/New Post ".*"/)
      fail('Author missing') unless e.text.match(/by .*@.*/)
      fail('TLP missing') unless e.text.match(/(Red|White|Green|Amber)/)
    end
  end
end

When /^I click on the "([^"]*)" tab in the What's happening widget$/ do |tab|
  visit_and_benchmark(HomePage) do |home|
    home.wait_until do
      home.whats_happening?
    end

    case tab
      when 'Following'
        home.following_element.click
      when 'Popular'
        home.popular_element.click
      else
        fail('Tab not recognised')
    end
  end
end

Then /^I am presented with content from the people I am following$/ do
  on(HomePage) do |home|
    home.entry_elements.each do |e|
      fail('Title missing') unless e.text.match(/New Post ".*"/)
      fail('Author missing') unless e.text.match(/by .*@.*/)
      fail('TLP missing') unless e.text.match(/(Red|White|Green|Amber)/)
    end
  end
end