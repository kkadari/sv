And /^I archive the poll$/ do
  on PollSummaryPage do |poll|
    poll.archive

    poll.wait_until do
      poll.archive_confirmation_element.exists?
    end

    poll.confirm_archive
  end

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject

  on PollSummaryPage do |poll|
    poll.wait_until do
      poll.poll_ended_element.exists?
    end
  end

  fail 'Poll not archived' unless @browser.html.to_s.include? 'This poll was archived on'
end

Then /^I can edit the poll and it remain archived$/ do
  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  on(PollSummaryPage).edit
  on(EditPollPage).subject = @subject
  on(EditPollPage).save

  on(PollSummaryPage).wait_until do
    on(PollSummaryPage).title_element.exists?
  end

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  fail 'Poll did not remain archived' unless @browser.html.to_s.include? 'This poll ended on'
end