require 'spec_helper'

describe 'Item view toggle widget' do

  it 'should return a 200 when a view toggle is requested' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/users/current/prop/browse.content.itemviewtoggle','thumb', {:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 204
    }
  end

end