require 'spec_helper'

describe 'View poll page' do

  it 'should return a 200 when viewing a poll' do
    response1 = CreateContent.get_create_poll(@authorisation)
    poll_id = Nokogiri::HTML.parse(response1).css('input[name="pollID"]')[0]['value']

    response2 = CreateContent.get_poll_choice(poll_id, @authorisation)
    choice = JSON.parse(response2)['id']

    payload = PollPayload
                  .new(@authorisation,
                       poll_id,
                       choice,
                       Faker::Lorem.sentence(3),
                       Faker::Lorem.sentence(20),
                       'random',
                       Faker::Lorem.words(2).join(','),
                       {:type => 'community'}).payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/polls',payload,{:cookie => @authorisation,:content_type => 'application/json; charset=UTF-8'}){|response|
      @payload = JSON.parse(response.body)
    }

    RestClient.get(ENV['base_url'] + '/' + @payload['redirect'],:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end
