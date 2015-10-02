require 'spec_helper'

describe 'Profile places page' do

  it 'should return a 200 when requesting the places page' do
    RestClient.get(ENV['base_url'] + '/people/' + ENV['username'] + '/places',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end



end