require 'spec_helper'

describe 'User bookmarks page' do

  it 'should return a 200 when requesting bookmark page' do
    RestClient.get(ENV['base_url'] + '/people/' + ENV['username'] + '/bookmarks',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end