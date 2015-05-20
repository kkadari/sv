Then (/^I have requested a new group is created with an additional owner and a supporter$/) do
  @title = TitleCreator.create_title_for('group')
  on(GlobalNav).verify_cannot_create('request_group')
  on(GlobalNav).request_group_created :name => @title
end