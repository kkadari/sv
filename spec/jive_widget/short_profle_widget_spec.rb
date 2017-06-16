require 'spec_helper'

describe 'Short profile widget' do

  it 'should return a 200 when requesting the short profile of a user' do
    RestClient.get(ENV['base_url'] + '/profile-short.jspa?tooltip=true&userID=' + @id,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting the short profile of a group' do
    RestClient.get(ENV['base_url'] + '/container-short.jspa?tooltip=true&container=' + @space_id + '&containerType=14',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end
