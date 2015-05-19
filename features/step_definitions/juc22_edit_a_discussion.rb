Then /^I can edit the discussion$/ do
  on(DiscussionSummaryPage).click_edit

  on EditDiscussionPage do |edit|
    @new_subject = "=Edited= ".concat edit.subject
    edit.subject = @new_subject
    edit.save
  end

  on(DiscussionSummaryPage).wait_until do
    on(DiscussionSummaryPage).title_element.exists?
  end

  fail 'Content not visible or created' unless @browser.html.to_s.include? @new_subject
end

Then /^I can change the discussion marking$/ do
  on(DiscussionSummaryPage).click_edit

  on EditDiscussionPage do |edit|
    @new_color = edit.edit_handling_level
    edit.save
  end

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(DiscussionSummaryPage).correct_ihm_displayed(@new_color)
end