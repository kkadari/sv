Then /^I can delete the incident report$/ do
  DeleteContent.delete_ir(@incident_id, @browser.cookies.to_a)
end