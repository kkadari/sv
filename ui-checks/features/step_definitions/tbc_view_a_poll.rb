Then /^I can view the poll$/ do
  on(PollSummaryPage).wait_until do
    on(PollSummaryPage).comment? #comment link is one of the last things to load.
  end

  fail 'Title not visible' unless on(PollSummaryPage).title?
  fail 'IHM not visible' unless on(PollSummaryPage).ihm_bar?
  fail 'Poll choice not visible' unless on(PollSummaryPage).first_poll_choice?
  fail 'Comment not visible' unless on(PollSummaryPage).comment?
end
