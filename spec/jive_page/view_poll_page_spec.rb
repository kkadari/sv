require 'spec_helper'

describe 'View poll page' do

  it 'should return a 200 when viewing a poll' do
    payload = PollPayload
                  .new(@authorisation,
                       Faker::Lorem.sentence(3),
                       Faker::Lorem.sentence(20),
                       'random',
                       Faker::Lorem.words(2).join(',')).payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/polls',payload,{:cookie => @authorisation,:content_type => 'application/json; charset=UTF-8'}){|response|
      @payload = JSON.parse(response.body)
    }

    RestClient.get(ENV['base_url'] + '/' + @payload['redirect'],:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end