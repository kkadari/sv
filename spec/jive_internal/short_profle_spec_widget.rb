require 'spec_helper'

describe 'Short profile widget' do

  it 'should return a 200 when requesting the short profile of a user' do
    RestClient.get(ENV['base_url'] + '/profile-short.jspa?tooltip=true&userID=2012',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end