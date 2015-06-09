require 'spec_helper'

describe 'Content page' do

  it 'should return a 200 when requested' do
    RestClient.get(ENV['base_url'] + '/content',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end