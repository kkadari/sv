require 'spec_helper'

describe 'User bookmarks page' do

  it 'should return a 200 when requesting bookmark page' do
    RestClient.get(ENV['base_url'] + '/people/' + ENV['username'] + '/bookmarks',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end