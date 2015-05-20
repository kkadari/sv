Then /^I can edit the discussion$/ do
  on(DiscussionSummaryPage).edit

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
  on(DiscussionSummaryPage).edit

  on EditDiscussionPage do |edit|
    edit.handling_elements.each do |colour|
      colour.click if colour.text.downcase.include? 'white'
    end
    edit.save
  end

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(DiscussionSummaryPage).ihm_bar.downcase.include? 'white'
end