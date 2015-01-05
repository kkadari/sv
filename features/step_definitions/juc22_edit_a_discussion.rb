Then (/^I can edit the discussion$/) do
  on(DiscussionSummaryPage).click_edit
  @new_subject = on(DiscussionEditPage).change_subject
  on(DiscussionSummaryPage).verify_content_exists(@new_subject)
end

Then (/^I can change the discussion marking$/) do
  on(DiscussionSummaryPage).click_edit
  @new_color = on(DiscussionEditPage).change_handling_level
  on(DiscussionSummaryPage).verify_content_exists(@subject)
  on(DiscussionSummaryPage).correct_ihm_displayed(@new_color)
end