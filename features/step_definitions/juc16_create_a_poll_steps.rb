Then /^I can vote on the poll$/ do
  visit_and_benchmark PollSummaryPage, :using_params => {:id => @incident_id} do |poll|
    poll.select_first_poll_choice
    poll.vote
  end

end