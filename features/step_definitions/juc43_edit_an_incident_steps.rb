Then (/^I can edit the anonymous incident report$/) do
  on(IncidentReportSummaryPage).click_edit
  on(IncidentReportEditPage).verify_page_title
  @new_subject = on(IncidentReportEditPage).change_subject
  on(IncidentReportSummaryPage).verify_content_exists(@new_subject)
end

Then (/^I can change incident report marking$/) do
  on(IncidentReportSummaryPage).click_edit
  on(IncidentReportEditPage).verify_page_title
  @new_color = on(IncidentReportEditPage).change_handling_level
  on(IncidentReportSummaryPage).verify_content_exists(@subject)
  on(IncidentReportSummaryPage).correct_ihm_displayed(@new_color)
end