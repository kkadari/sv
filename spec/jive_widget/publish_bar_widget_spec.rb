require 'spec_helper'

describe 'Publish bar widget' do

  it 'should return a 200 when searching calling up suggestions' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/containers/suggested/1?containerType=-1&containerID=-1',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when calling the publish bar view' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/publishbar/view?objectType=1&objectID=-1&visibility=place&containerType=14&containerID=' + @space_id,{:cookie => @authorisation, :accept => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end