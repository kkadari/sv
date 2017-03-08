require 'spec_helper'

describe 'About place widget' do

  it 'should return a 200 when details about the place are requested' do
    RestClient.get(ENV['base_url'] + '/community/about-place.jspa?containerID=' + @space_id.to_s + '&containerType=14',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

end
