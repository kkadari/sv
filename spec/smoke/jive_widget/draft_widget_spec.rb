require 'spec_helper'

describe 'Draft widget' do

  it 'should return a 200 when saving a draft on an item' do
    payload = '{"objectType":1,"draftObjectType":2020,"draftObjectID":1006,"subject":"A different draft to be saved","body":"<body><p>Details here</p></body>","properties":{"publishBar":{"visibility":"place"},"markAsQuestion":false,"handlingLevel":"2"}}'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/draft',payload,{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting drafts' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/draft/',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 204
    }
  end

  it 'should return a 204 when requesting all draft instances' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/draft/1/2020/1006',{:cookie => @authorisation, :accept => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 204 when requesting a draft to delete' do
    payload = '{"objectType":1,"draftObjectType":2020,"draftObjectID":1006,"subject":"A different draft to be saved","body":"<body><p>Details here</p></body>","properties":{"publishBar":{"visibility":"place"},"markAsQuestion":false,"handlingLevel":"2"}}'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/draft',payload,{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
      @draft_id = JSON.parse(response)['id']
    }

    RestClient.delete(ENV['base_url'] + '/__services/v2/rest/draft/' + @draft_id.to_s,{:cookie => @authorisation, :accept => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 204
    }
  end

end