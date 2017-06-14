Then /^I can use Jive search to find the anonymous incident report$/ do
  20.times do
    response = Search.get_content_only_search(@subject.gsub(' ', '+'), $authorisation)
    response_parsed = JSON.parse(response.split('.\';')[1])

    if response_parsed['list'].length >= 1
      raise 'Subject not found in list' unless response_parsed['list'][0]['subject'] == @subject

      break
    else
      sleep(1)
    end
  end
end

Then /^I can use the spotlight search to find the incident report by ID$/ do
  20.times do
    response = Search.get_spotlight_content(@incident_id, $authorisation)
    response_parsed = JSON.parse(response.split('.\';')[1])

    if response_parsed['list'].length >= 1
      raise 'Subject not found in list' unless response_parsed['list'][0]['subject'] == @subject

      break
    else
      sleep(1)
    end
  end

end

Then /^I am not able to view their identity on the comment when I search for the incident report$/ do
  20.times do
    response = Search.get_content_only_search(@subject.gsub(' ', '+'), $authorisation)
    response_parsed = JSON.parse(response.split('.\';')[1])

    if response_parsed['list'].length >= 1
      comment_response = Comment.get_ir_comments(response_parsed['list'][0]['id'], $authorisation)
      raise 'Comment not anonymous' unless Nokogiri::HTML.parse(comment_response).css('.guest').text == 'Anonymous'

      break
    else
      sleep(1)
    end
  end
end

Given /^I have used spotlight search to search for a participant$/ do
  20.times do
    response = Search.get_spotlight_people(@test_config_set[:user_2_name], $authorisation)
    response_parsed = JSON.parse(response.split('.\';')[1])

    if response_parsed['list'].length >= 1
      @response = response_parsed

      break
    else
      sleep(1)
    end
  end
end

Then /^details for that participant are returned by Jive search$/ do
  fail 'User not visible' unless @response['list'][0]['displayName'] == @test_config_set[:user_2_name]
end
