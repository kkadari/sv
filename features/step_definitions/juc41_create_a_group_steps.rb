Then (/^I am not presented with a menu option to create a (group|space)$/) do |type|
  @type = type
  on(HomePage).verify_cannot_create(@type)
end

Then (/^I cannot create a (group|space) directly$/) do |type|
  @type = type
  case type
    when 'group'
      @browser.goto UrlFactory.cannotcreategrouppage
      fail 'Not presented with Unauthorized page' unless on(GroupPage).content_header_element.text.include?('Unauthorized')
    when 'space'
      @browser.goto UrlFactory.cannotcreateplacepage
      fail 'Not presented with Unauthorized page' unless on(PlacesPage).text.include?('Unauthorized')
    else
      fail 'Type not recognised.'
  end
end