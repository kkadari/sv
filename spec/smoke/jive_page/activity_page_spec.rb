require 'spec_helper'

describe 'Activity page' do

  it 'should return a 200 when requesting the activity page' do
    RestClient.get(ENV['base_url'] + '/activity',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting the recommendations enable' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/recommendation/enabled/',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when switching to a new feed' do
    payload = '{"objectType":3,"objectID":' + @id + ',"streamSource":"connections","streamID":"' + @stream_id + '","filterType":["all"],"timestamp":"0","includeUpdateCount":true}'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/activity-stream/list',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting the main feed' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/recommendation/allrecommendations/home?trendingMax=9&usersMax=15',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end

