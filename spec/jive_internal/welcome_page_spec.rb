require 'spec_helper'

describe 'Welcome page' do

  it 'should return a 200 status code when requested' do
    RestClient.get(ENV['base_url'] + '/welcome',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a redirect to the slideshow config which will then return a 200' do
    RestClient.get(ENV['base_url'] + '/slideshow-config',:cookie => @authorisation){|response|
      @location = response.headers[:location]
    }

    RestClient.get(ENV['base_url'] + '/' + @location,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when getting the count for the activity stream' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/activity-stream/new/count',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when calling the container security token' do
    timestamp = Time.now.to_i.to_s

    RestClient.get(ENV['base_url'] + '/__services/v2/rest/apps/v1/containersecuritytoken?_=' + timestamp,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end