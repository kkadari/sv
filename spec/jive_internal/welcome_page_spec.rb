require 'spec_helper'

describe 'Welcome page' do

  it 'should return a 200 status code when requested' do
    RestClient.get(ENV['base_url'] + '/welcome',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end