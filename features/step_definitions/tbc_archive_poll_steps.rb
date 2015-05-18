And /^I archive the poll$/ do
  on(PollSummaryPage).archive_poll
  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(PollSummaryPage).wait_for_poll_archived

  fail 'Poll not archived' unless @browser.html.to_s.include? 'This poll was archived on'
end

Then /^I can edit the poll and it remain archived$/ do
  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(PollSummaryPage).edit_poll
  on(PollEditPage).edit_subject(@subject)

  on(PollSummaryPage).wait_until do
    on(PollSummaryPage).title_element.exists?
  end

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  fail 'Poll did not remain archived' unless @browser.html.to_s.include? 'This poll ended on'
end