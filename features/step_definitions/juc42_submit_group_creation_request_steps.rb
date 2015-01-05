Then (/^I have requested a new group is created with an additional owner and a supporter$/) do
  @title = on(HomePage).create_title_for('group')
  on(HomePage).create('request_group')
  on(HomePage).request_group_created :name => @title
end