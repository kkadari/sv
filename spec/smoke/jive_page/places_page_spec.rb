require 'spec_helper'

describe 'Places view page' do

  it 'should return a 200 when requesting the place page' do
    RestClient.get(ENV['base_url'] + '/places',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting the view change' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/users/current/prop/browse.places.itemviewtoggle','list', {:cookie => @authorisation,:content_type => 'application/json'}){|response|
      assert_code_and_body(response, 204)
    }
  end

end

