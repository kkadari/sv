Given /^that "([^"]*)" and "([^"]*)" are not following one another$/ do |user1, user2|
  switch_user(user1)

  user_1_profile = TestConfig.return_profile(user1)
  user_2_profile = TestConfig.return_profile(user2)

  Follow.delete_follow_connection_v3(user_1_profile[:user_id], user_2_profile[:user_id], $authorisation)
end

Given /^I select to follow "([^"]*)"$/ do |user|
  user_profile = TestConfig.return_profile(user)

  payload = FollowPayload.new(3, user_profile[:user_id]).payload
  Follow.post_follow_request(payload, $authorisation)
end

When /^"([^"]*)" accepts the connection request$/ do |user|
  switch_user(user)

  response = Inbox.get_connections_inbox_message($authorisation)
  entry_id = JSON.parse(response.split(';',0)[1])['actionQueueList'][0]['entryID'].to_s
  user_profile = TestConfig.return_profile(user)

  payload = ManageFollowPayload.new(user_profile[:user_id], entry_id, 'accept').payload
  Follow.post_action_follow_request(payload, $authorisation)
end

Then /^"([^"]*)" will get a confirmation that "([^"]*)" has accepted my request$/ do |user1, user2|
  switch_user(user1)

  user_profile = TestConfig.return_profile(user2)
  response = Inbox.get_connections_inbox_message($authorisation)

  fail('Follow request acceptance failed') if JSON.parse(response.split(';',0)[1])['actionQueueList'][0]['templateData']['relatedUser']['username'] != user_profile[:username]
end

When /^"([^"]*)" rejects the connection request$/ do |user|
  switch_user(user)

  response = Inbox.get_connections_inbox_message($authorisation)
  entry_id = JSON.parse(response.split(';',0)[1])['actionQueueList'][0]['entryID'].to_s

  user_profile = TestConfig.return_profile(user)
  payload = ManageFollowPayload.new(user_profile[:user_id], entry_id, 'reject').payload

  Follow.post_action_follow_request(payload, $authorisation)
end

Then /^"([^"]*)" will receive a notification that my request has not been accepted$/ do |user|
  switch_user(user)

  response = Inbox.get_connections_inbox_message($authorisation)
  fail('Follow rejection not received') unless JSON.parse(response.split(';',0)[1])['actionQueueList'][0]['templateData']['messageKey'].include? 'rejected_notification'
end

Then /^"([^"]*)" is not listed as a follower of "([^"]*)"$/ do |user1, user2|
  switch_user(user1)

  user_1_profile = TestConfig.return_profile(user1)
  user_2_profile = TestConfig.return_profile(user2)

  response = Profile.get_people_followed(user_1_profile[:username], $authorisation)
  fail('User found in list when they should not be there') if response.include? user_2_profile[:username]
end

Given /^I am following "([^"]*)"$/ do |user|
  user_profile = TestConfig.return_profile(user)

  payload = FollowPayload.new(3, user_profile[:user_id]).payload
  Follow.post_follow_request(payload, $authorisation)

  switch_user(user)

  response = Inbox.get_connections_inbox_message($authorisation)
  entry_id = JSON.parse(response.split(';',0)[1])['actionQueueList'][0]['entryID'].to_s
  user_profile = TestConfig.return_profile(user)

  payload = ManageFollowPayload.new(user_profile[:user_id], entry_id, 'accept').payload
  Follow.post_action_follow_request(payload, $authorisation)
end

When /^I sever the connection with "([^"]*)" as "([^"]*)"$/ do |user1, user2|
  switch_user(user2)

  user_profile = TestConfig.return_profile(user1)

  Follow.delete_follow_connection(user_profile[:user_id], $authorisation)
end