And /^I archive the poll$/ do
  on(PollSummaryPage).archive_poll
  on(PollSummaryPage).verify_content_exists(@subject)
  on(PollSummaryPage).confirm_poll_archived
end

Then /^I can edit the poll and it remain archived$/ do
  on(PollSummaryPage).verify_content_exists(@subject)
  on(PollSummaryPage).edit_poll
  on(PollEditPage).edit_subject(@subject)
  on(PollSummaryPage).verify_content_exists(@subject)
  on(PollSummaryPage).confirm_poll_remains_archived
end