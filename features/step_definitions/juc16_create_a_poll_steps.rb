Then /^I can vote on the poll$/ do
  payload = 'ratingType=like&voteValue=1'

  Vote.post_vote(@poll_id, payload, $authorisation)
end
