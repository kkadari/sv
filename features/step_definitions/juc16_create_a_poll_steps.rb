Then /^I can vote on the poll$/ do
  visit PollSummaryPage, :using_params => {:id => @incident_id}

  on PollSummaryPage do |poll|
    poll.select_first_poll_choice
    poll.vote
    poll.confirm_vote
  end

end