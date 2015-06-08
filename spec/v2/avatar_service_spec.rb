require 'spec_helper'

describe 'avatar_service_v2' do

  it 'should return a 200 when geting the default avatar' do
    RestClient.get('http://dev188.sure.vine/api/core/v2/avatars/default', :Authorization => @authorisation) { |response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when geting the disabled avatar' do
    RestClient.get('http://dev188.sure.vine/api/core/v2/avatars/disabled', :Authorization => @authorisation) { |response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when geting the system avatar' do
    RestClient.get('http://dev188.sure.vine/api/core/v2/avatars/1', :Authorization => @authorisation) { |response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end