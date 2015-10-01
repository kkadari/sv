require 'spec_helper'

describe 'Create poll page' do

  it 'should return a 200 when requesting the create poll page' do
    RestClient.get(ENV['base_url'] + '/poll/create.jspa?sr=cmenu&containerType=14&containerID=1',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting a new poll choice' do
    RestClient.get('http://dev188.sure.vine/poll/create.jspa?sr=cmenu&containerType=14&containerID=1',:cookie => @authorisation){|response|
      @poll_id = response.body.scan(/name="pollID" value="([0-9]*)/).join(",")
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/polls/' + @poll_id + '/pollOptions','',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when creating a poll' do
    response1 = CreateContent.get_create_poll(@authorisation)
    poll_id = Nokogiri::HTML.parse(response1).css('input[name="pollID"]')[0]['value']

    response2 = CreateContent.get_poll_choice(poll_id, @authorisation)
    choice = JSON.parse(response2)['id']

    payload = PollPayload
                  .new(@authorisation,
                       poll_id,
                       choice,
                       'Testing poll 2',
                       'body content goes here',
                       'green',
                       'Information text ',
                      {:type => 'community'}).payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/polls',payload,{:cookie => @authorisation,:content_type => 'application/json; charset=UTF-8'}){|response|
      assert_code_and_body(response, 200)
    }
  end
end