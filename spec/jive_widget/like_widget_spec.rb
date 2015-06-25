require 'spec_helper'

describe 'Like widget' do

  it 'should return a 200 when requesting the like list of a piece of content' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/activity/users/like/2/3697?count=20&start=0&_=1434966527868',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end