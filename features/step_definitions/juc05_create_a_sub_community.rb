Given /^I have opted to create a new group as "([^"]*)"$/ do |user|
  switch_user(user)

  response = Places.get_create_group($authorisation)
  @draft_group_id = response.scan(/"browseID":[0-9]*/)[0].split(':')[1]
end

When /^I create a "([^"]*)" group$/ do |group_type|
  @group_name = group_type + '-' + Time.now.to_i.to_s
  payload = GroupPayload.new(@group_name, group_type.upcase).payload
  response = Places.put_v3_group(@draft_group_id, payload, $authorisation)
  @delete_id = JSON.parse(response)['id']
end

Then /^the group is created successfully$/ do
  5.times do |i|
    begin
      response = Places.get_places($authorisation)
      fail('Group does not exist') unless response.include? @group_name
      break
    rescue => e
      if i < 5
        sleep(1)
      else
        fail(e)
      end
    end
  end
end

Then /^I am displayed the group overview page$/ do
  Places.get_group(@group_name, $authorisation)

  # Delete the group once we've confirmed it has been created.  Otherwise we will be spammed with groups.
  Places.post_delete_group(@delete_id, $authorisation)
end

Given /^I create a "([^"]*)" group with content$/ do |group_type|
  @group_name = group_type + '-' + Time.now.to_i.to_s
  payload = GroupPayload.new(@group_name, group_type.upcase).payload
  response = Places.put_v3_group(@draft_group_id, payload, $authorisation)
  @group_id = JSON.parse(response)['id']

  payload = IncidentReportPayload.new(TitleCreator.create_title_for('incident'),false,'Lorem ipsumy goodness','white',{:type => 'specific group', :id => @group_id},'',false).payload
  response2 = CreateContent.create_incident_report(payload, $authorisation)
  @incident_id = response2['redirect'][/[0-9]+/,0]
end

When /^I opt to delete the group$/ do
  Places.post_delete_group(@group_id, $authorisation)
end

Then /^the group is deleted$/ do
  response = Places.get_places($authorisation)
  fail('Group still exists') if response.include? 'Auto group to delete'
end

Then /^all content created within that group no longer exists$/ do
  Content.get_ir(@incident_id, $authorisation, 404)
end
