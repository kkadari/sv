Then(/^I can vote on the poll$/) do
  visit PollSummaryPage, :using_params => {:id => @incident_id}

  on(PollSummaryPage).vote_on_poll
  on(PollSummaryPage).confirm_vote
end