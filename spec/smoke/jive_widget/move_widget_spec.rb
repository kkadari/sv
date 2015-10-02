require 'spec_helper'

describe 'Move content widget' do

  it 'should return a 200 when requesting the move popup' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/placepicker/move?containerType=2020&containerID=1006&contentType=18&contentID=1831',{:cookie => @authorisation, :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when spaces and groups to move to' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/containers?contentType=18&contentID=1831&filterGroupID=placePicker&filterID=following&start=0&sortKey=subject&numResults=20',{:cookie => @authorisation, :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting capabilities of a place to move to' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/content/18/1831/capabilities?containerType=14&containerID=' + @space_id,{:cookie => @authorisation, :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

end