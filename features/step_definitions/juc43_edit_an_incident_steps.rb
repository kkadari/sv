Then /^I can change incident report marking$/ do
  response = EditContent.get_edit_ir(@incident_id, $authorisation)
  token = Nokogiri::HTML.parse(response).css('input[name="jive.token.content.incidentReport.create"]')[0]['value']

  payload = EditIrPayload.new(token, @incident_id, '=edited= ' + @subject, 'Updated IR>', 'white', {:type => 'community'}).payload

  EditContent.put_edit_ir(@incident_id, payload, $authorisation)

  ir = Content.get_ir(@incident_id, $authorisation)
  ihm = Nokogiri::HTML.parse(ir).css('.ihmbar').text.downcase

  fail 'IHM not updated' unless ihm.include? 'white'
end