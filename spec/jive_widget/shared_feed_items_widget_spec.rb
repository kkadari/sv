require 'spec_helper'

describe 'Shared feed items' do

  it 'should return a 200 when requesting more feed items' do
    payload = '{"objectType":3,"objectID":' + @id + ',"streamSource":"all","streamID":"' + @stream_id + '","filterType":["all"],"timestamp":"1434975953005","includeUpdateCount":false}'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/activity-stream/list/before',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting full content of an item' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/activity-stream/fullcontent/2/3776',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end