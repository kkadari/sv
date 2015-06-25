require 'spec_helper'

describe 'The profile activity page' do

  it 'should return a 200 when requesting the profile activity' do
    RestClient.get(ENV['base_url'] + '/people/' + ENV['username'] + '/activity',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting similar users' do
    RestClient.get(ENV['base_url'] + '/similar-users.jspa?targetUser=' + @id,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting most liked' do
    RestClient.get(ENV['base_url'] + '/most-liked.jspa?containerType=14&container=1&numResults=10&filterUserID=' + @id,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting details on a poll' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/polls/1833/getBean',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end