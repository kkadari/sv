require 'spec_helper'

describe 'Create new feed' do

  it 'should return a 200 when requesting the create new feed page' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/stream-config/getInitialView','new',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting the config for a new stream' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/stream-config/54',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting search recommendations' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/stream-config/getSearchSuggestions',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting all followed users' do
    RestClient.get(ENV['base_url'] + '/api/core/v3/people/2012/followingIn',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end