require 'spec_helper'

describe 'discussion_service_v2' do

  it 'should return a 200 when getting a discussion' do
    RestClient.get('http://dev188.sure.vine/api/core/v2/discussions/2606', :Authorization => @authorisation) { |response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when getting a discussions messages' do
    RestClient.get('http://dev188.sure.vine/api/core/v2/discussions/2606/messages?limit=10', :Authorization => @authorisation) { |response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when getting a discussions messages' do
    RestClient.get('http://dev188.sure.vine/api/core/v2/discussions/2606/tracks/' + ENV['user_id'], :Authorization => @authorisation) { |response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 201 when posting a follower to the discussion' do
    RestClient.post('http://dev188.sure.vine/api/core/v2/discussions/2606/followers',  '{id: ' + ENV['user_id'] + '}', :Authorization => @authorisation) { |response|
      fail('Failed with ' + response.code.to_s) if response.code != 201
    }
  end

  it 'should return a 200 when getting a discussion follower' do
    RestClient.get('http://dev188.sure.vine/api/core/v2/discussions/2606/followers/' + ENV['user_id'], :Authorization => @authorisation) { |response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when delete a discussion follower' do
    RestClient.delete('http://dev188.sure.vine/api/core/v2/discussions/2606/followers/' + ENV['user_id'], :Authorization => @authorisation) { |response|
      fail('Failed with ' + response.code.to_s) if response.code != 204
    }
  end

end