require 'spec_helper'

describe 'authentication_service_v2' do

  it 'should return a 200 when logging in' do
    payload = 'username=' + ENV['username'] + '&password=' + ENV['password']

    RestClient.post('http://dev188.sure.vine/api/core/v2/authentication/formlogin',payload,:Authorization => @authorisation) { |response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when logging out' do
    RestClient.delete('http://dev188.sure.vine/api/core/v2/authentication/login',:Authorization => @authorisation) { |response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end