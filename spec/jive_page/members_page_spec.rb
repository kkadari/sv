require 'spec_helper'

describe 'People page' do

  it 'should return a 200 when requested' do
    RestClient.get(ENV['base_url'] + '/people',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting search details for users' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/users/' + @id + '/browse',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end
