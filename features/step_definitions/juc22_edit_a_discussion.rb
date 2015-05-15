Then (/^I can edit the discussion$/) do
  on(DiscussionSummaryPage).click_edit
  @new_subject = on(DiscussionEditPage).change_subject

  fail 'Content not visible or created' unless @browser.html.to_s.include? @new_subject
end

Then (/^I can change the discussion marking$/) do
  on(DiscussionSummaryPage).click_edit
  @new_color = on(DiscussionEditPage).change_handling_level

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(DiscussionSummaryPage).correct_ihm_displayed(@new_color)
end