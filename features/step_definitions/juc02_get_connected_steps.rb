Given /^that "([^"]*)" and "([^"]*)" are not following one another$/ do |user1, user2|
  switch_user(user1)

  user_1_profile = TestConfig.return_profile(user1)
  user_2_profile = TestConfig.return_profile(user2)

  RestClient.delete(ENV['base_url'] + '/api/core/v3/people/' + user_1_profile[:user_id] + '/@following/' + user_2_profile[:user_id], :cookie => Request.create_cookie(@browser.cookies.to_a)){|response|
    if response.code != 204 && response.code != 409
      fail('Failed with ' + response.code.to_s)
    end
  }
end

Given /^I select to follow "([^"]*)"$/ do |user|
  user_profile = TestConfig.return_profile(user)
  payload = '[{"objectType":"3","objectID":"' + user_profile[:user_id] + '"}]'

  RestClient.post(ENV['base_url'] + '/__services/v2/rest/stream-config/user/associations/manage', payload, {:cookie => Request.create_cookie(@browser.cookies.to_a), :content_type => 'application/json'}){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 200
  }
end

When /^"([^"]*)" accepts the connection request$/ do |user|
  switch_user(user)

  RestClient.get(ENV['base_url'] + '/__services/v2/rest/action-queue/list?categoryID=1002&type=active&numResults=1', {:cookie => Request.create_cookie(@browser.cookies.to_a), :content_type => 'application/json'}){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 200

    @entry_id = JSON.parse(response.split(';',0)[1])['actionQueueList'][0]['entryID'].to_s
  }

  user_profile = TestConfig.return_profile(user)
  payload = '{"userID":"' + user_profile[:user_id] + '","itemID":' + @entry_id + ',"actionCode":1,"message":""}'

  RestClient.post(ENV['base_url'] + '/__services/v2/rest/action-queue/performAction', payload, {:cookie => Request.create_cookie(@browser.cookies.to_a), :content_type => 'application/json'}){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 200
  }
end

Then /^"([^"]*)" will get a confirmation that "([^"]*)" has accepted my request$/ do |user1, user2|
  switch_user(user1)

  user_profile = TestConfig.return_profile(user2)

  RestClient.get(ENV['base_url'] + '/__services/v2/rest/action-queue/list?categoryID=1002&type=active&numResults=1', {:cookie => Request.create_cookie(@browser.cookies.to_a), :content_type => 'application/json'}){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 200
    fail('Follow request acceptance failed') if JSON.parse(response.split(';',0)[1])['actionQueueList'][0]['templateData']['relatedUser']['username'] != user_profile[:username]
  }
end

When /^"([^"]*)" rejects the connection request$/ do |user|
  switch_user(user)

  RestClient.get(ENV['base_url'] + '/__services/v2/rest/action-queue/list?categoryID=1002&type=active&numResults=1', {:cookie => Request.create_cookie(@browser.cookies.to_a), :content_type => 'application/json'}){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 200

    @entry_id = JSON.parse(response.split(';',0)[1])['actionQueueList'][0]['entryID'].to_s
  }

  user_profile = TestConfig.return_profile(user)
  payload = '{"userID":"' + user_profile[:user_id] + '","itemID":' + @entry_id + ',"actionCode":2,"message":""}'

  RestClient.post(ENV['base_url'] + '/__services/v2/rest/action-queue/performAction', payload, {:cookie => Request.create_cookie(@browser.cookies.to_a), :content_type => 'application/json'}){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 200
  }
end

Then /^"([^"]*)" will receive a notification that my request has not been accepted$/ do |user|
  switch_user(user)

  RestClient.get(ENV['base_url'] + '/__services/v2/rest/action-queue/list?categoryID=1002&type=active&numResults=1', {:cookie => Request.create_cookie(@browser.cookies.to_a), :content_type => 'application/json'}){|response|
    fail('Follow rejection not received') unless JSON.parse(response.split(';',0)[1])['actionQueueList'][0]['templateData']['messageKey'].include? 'rejected_notification'
  }
end

Then /^"([^"]*)" is not listed as a follower of "([^"]*)"$/ do |user1, user2|
  switch_user(user1)

  user_1_profile = TestConfig.return_profile(user1)
  user_2_profile = TestConfig.return_profile(user2)

  RestClient.get(ENV['base_url'] + '/people/' + user_1_profile[:username] + '/people', :cookie => Request.create_cookie(@browser.cookies.to_a)){|response|
    fail('User found in list when they should not be there') if response.include? user_2_profile[:username]
  }
end

Given /^I am following "([^"]*)"$/ do |user|
  user_profile = TestConfig.return_profile(user)
  payload = '[{"objectType":"3","objectID":"' + user_profile[:user_id] + '"}]'

  RestClient.post(ENV['base_url'] + '/__services/v2/rest/stream-config/user/associations/manage', payload, {:cookie => Request.create_cookie(@browser.cookies.to_a), :content_type => 'application/json'}){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 200
  }

  switch_user(user)

  RestClient.get(ENV['base_url'] + '/__services/v2/rest/action-queue/list?categoryID=1002&type=active&numResults=1', {:cookie => Request.create_cookie(@browser.cookies.to_a), :content_type => 'application/json'}){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 200

    @entry_id = JSON.parse(response.split(';',0)[1])['actionQueueList'][0]['entryID'].to_s
  }

  user_profile = TestConfig.return_profile(user)
  payload = '{"userID":"' + user_profile[:user_id] + '","itemID":' + @entry_id + ',"actionCode":1,"message":""}'

  RestClient.post(ENV['base_url'] + '/__services/v2/rest/action-queue/performAction', payload, {:cookie => Request.create_cookie(@browser.cookies.to_a), :content_type => 'application/json'}){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 200
  }
end

When /^I sever the connection with "([^"]*)" as "([^"]*)"$/ do |user1, user2|
  switch_user(user2)

  user_profile = TestConfig.return_profile(user1)

  RestClient.delete(ENV['base_url'] + '/__services/v2/rest/stream-config/3/' + user_profile[:user_id], {:cookie => Request.create_cookie(@browser.cookies.to_a), :content_type => 'text/plain'}){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 204
  }
end