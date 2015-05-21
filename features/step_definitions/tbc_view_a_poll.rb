Then /^I can view the poll$/ do
  on(PollSummaryPage).wait_until do
    on(PollSummaryPage).title?
  end

  fail 'Title not visible' unless on(PollSummaryPage).title?
  fail 'IHM not visible' unless on(PollSummaryPage).ihm_bar?
  fail 'Document not visible' unless on(PollSummaryPage).document?
  fail 'Comment not visible' unless on(PollSummaryPage).comment?
end