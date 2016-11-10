Then /^I can vote on the poll$/ do
  payload = 'optionID=' + @poll_choice.to_s  # This is WIP!

  Vote.post_vote(@poll_id, payload, $authorisation)
end
