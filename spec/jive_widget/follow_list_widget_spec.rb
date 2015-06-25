require 'spec_helper'

describe 'User connections widget' do

  it 'should return a 200 when requesting a list of followers for a user' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/activity/users/connections/3/2012',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end