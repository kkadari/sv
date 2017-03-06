require 'spec_helper'

describe 'Item view toggle widget' do

  it 'should return a 200 when a view toggle is requested' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/users/current/prop/browse.content.itemviewtoggle','thumb', {:cookie => @authorisation,:content_type => 'application/json'}){|response|
      assert_code_and_body(response, 204)
    }
  end

  it 'should return a 200 when requesting one of the filtered views of places' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/containers?filterGroupID=places&itemViewID=thumb&start=0&numResults=20&filterID=historyarchetype%5Bcontainers%5D&itemView=thumb&userID=' + @id,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end
