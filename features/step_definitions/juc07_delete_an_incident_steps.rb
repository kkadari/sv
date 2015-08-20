Then /^I can delete the incident report$/ do
  DeleteContent.delete_ir(@incident_id, $authorisation)
end