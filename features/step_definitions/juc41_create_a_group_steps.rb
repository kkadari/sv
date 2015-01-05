Then (/^I am not presented with a menu option to create a (group|space)$/) do |type|
  @type = type
  on(HomePage).verify_cannot_create(@type)
end

Then (/^I cannot create a (group|space) directly$/) do |type|
  @type = type
  case type
    when 'group'
      on(GroupPage).verify_cannot_create_group
    when 'space'
      on(PlacesPage).verify_cannot_create_place 
    else
      fail 'Type not recognised.'
  end
end