Then (/^I am not presented with a menu option to create a (group|space)$/) do |type|
  @type = type

  on(GlobalNav) do |menu|
    menu.open_create
    menu.wait_until do
      menu.create_menu?
    end

    case type
      when 'group'
        fail 'User should not have option to create group.' if menu.create_group?
      when 'space'
        fail 'User should not have option to create space.' if menu.create_space?
      else
        fail 'Supplied link type not defined.'
    end
  end

end

Then (/^I cannot create a (group|space) directly$/) do |type|
  @type = type
  case type
    when 'group'
      @browser.goto UrlFactory.cannotcreategrouppage
      fail 'Not presented with Unauthorized page' unless on(CreateGroupPage).content_header_element.text.include?('Unauthorized')
    when 'space'
      @browser.goto UrlFactory.cannotcreateplacepage
      fail 'Not presented with Unauthorized page' unless on(PlacesPage).text.include?('Unauthorized')
    else
      fail 'Type not recognised.'
  end
end