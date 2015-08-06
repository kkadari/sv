Then /^I will see a menu option name "([^"]*)" with the following submenu options$/ do |menu, menu_items|
  switch_user('participant A')

  visit_and_benchmark HomePage do |home|
    case menu
      when 'Content'
        home.content
      when 'Members'
        home.members
      when 'Places'
        home.places
      else
        raise 'Menu item not recognised'
    end

    captured_menu_items = home.menu_item_elements

    count = 0
    menu_items.raw.each do |menu_item|
      fail 'Menu sub-item mismatch expected: ' + menu_item[0] + ' got: ' + captured_menu_items[count].text unless menu_item[0] == captured_menu_items[count].text
      count += 1
    end
  end

end

Given /^I've visited various groups and places$/ do
  switch_user('participant A')

  visit_and_benchmark ViewSpacePage
end

When /^I open the Places menu$/ do
  visit_and_benchmark HomePage do |home|
    home.places
  end
end

Then /^I will see a list of groups and places I've recently visited$/ do
  on HomePage do |home|
    fail 'Recent space not found in places list' unless home.menu_item_elements[4].text.include? 'Getting Started'
  end
end

Then /^clicking on view more takes me to the recently viewed places page$/ do
  on(HomePage).view_more

  fail('Recently viewed page not selected') unless on(PlacesPage).active_menu_element.text.include? 'Recently Viewed'
end

When /^I click on the menu item My Colleagues in the Members menu$/ do
  switch_user('participant A')

  visit_and_benchmark HomePage do |home|
    home.members

    home.colleagues
  end
end

Then /^I am taken to a peoples list that is filtered by people in my organisation$/ do
  user_profiles = TestConfig.return_profile('participant A')
  organisation = user_profiles[:username].split('@')[1]

  on(PeoplePage).username_elements.each do |username|
    fail('User from outside organisation found') unless username.text.downcase.include? organisation
  end
end

Then /^I am presented with a customised footer with CISP specific links$/ do
  visit_and_benchmark HomePage do |home|
    fail('Footer could not be found') unless home.footer?

    links = ['Get Involved', 'Share an incident on CiSP', 'Share tips and techniques', 'Join groups and start discussion', 'Getting the most out of CiSP', 'Follow the CERT-UK Blog', 'How we can Help', 'CERT-UK Publications', 'Alerts & Advisories', 'CiSP Services', 'Support', 'Getting Started', 'Frequently Asked Questions', 'Contact Us', 'Members', 'Member directory', 'My profile', 'Email preferences']

    links.each do |link|
      fail('Expected to find ' + link + ' in footer') unless home.text.include? link
    end
  end
end