require 'spec_helper'

describe 'About place widget' do

  it 'should return a 200 when details about the place are requested' do
    RestClient.get(ENV['base_url'] + '/community/about-place.jspa?containerID=2009&containerType=14',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end