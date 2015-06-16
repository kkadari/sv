require 'spec_helper'

describe 'Tags widget' do

  it 'should return a 200 when requesting a group of tags' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/tags/cloud/10', :cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when searching for a specific tag' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/tags/search?query=test', :cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end