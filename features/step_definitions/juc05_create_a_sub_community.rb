Given /^I have opted to create a new group as "([^"]*)"$/ do |user|
  switch_user(user)

  response = Places.get_create_group(@browser.cookies.to_a)
  @draft_group_id = response.scan(/"browseID":[0-9]*/)[0].split(':')[1]
end

When /^I create a "([^"]*)" group$/ do |group_type|
  @group_name = group_type + '-' + Time.now.to_i.to_s

  payload = GroupPayload.new(@group_name, group_type.upcase).payload

  response = Places.put_v3_group(@draft_group_id, payload, @browser.cookies.to_a)
  @delete_id = JSON.parse(response)['id']
end

Then /^the group is created successfully$/ do
  response = Places.get_places(@browser.cookies.to_a)
  fail('Group does not exist') unless response.include? @group_name
end

Then /^I am displayed the group overview page$/ do
  Places.get_group(@group_name, @browser.cookies.to_a)

  # Delete the group once we've confirmed it has been created.  Otherwise we will be spammed with groups.
  Places.post_delete_group(@delete_id, @browser.cookies.to_a)
end

Given /^I create a "([^"]*)" group with content$/ do |group_type|
  payload = V3GroupPayload.new('autogroup','Auto group to delete',group_type.upcase).payload

  response = Places.post_v3_group(payload, @browser.cookies.to_a)
  @group_id = JSON.parse(response)['id']

  payload = IncidentReportPayload.new(TitleCreator.create_title_for('incident'),false,'Lorem ipsumy goodness','white',{:type => 'specific group', :id => @group_id},'',false).payload
  response2 = CreateContent.create_incident_report(payload, @browser.cookies.to_a)
  @incident_id = response2['redirect'][/[0-9]+/,0]
end

When /^I opt to delete the group$/ do
  Places.post_delete_group(@group_id, @browser.cookies.to_a)
end

Then /^the group is deleted$/ do
  response = Places.get_places(@browser.cookies.to_a)
  fail('Group still exists') if response.include? 'Auto group to delete'
end

Then /^all content created within that group no longer exists$/ do
  Content.get_ir(@incident_id, @browser.cookies.to_a, 404)
end