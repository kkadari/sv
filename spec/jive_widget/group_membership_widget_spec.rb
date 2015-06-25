require 'spec_helper'

describe 'Group membership widget' do

  it 'should return a 200 when joining a group' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/socialgroups/1004/members','',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting to leave a group' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/socialgroups/1004/memberInfo',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 204 when leaving a group' do
    RestClient.delete(ENV['base_url'] + '/__services/v2/rest/socialgroups/1004/members',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 204
    }
  end

  it 'should return a 200 when returning a members list of a group' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/activity/users/membership/700/1004',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end