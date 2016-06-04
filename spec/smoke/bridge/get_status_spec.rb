require 'bridge_helper'

describe 'Service Status API' do

  it 'should return a 200 when requesting the service status' do
    RestClient.get(ENV['bridge_url'] + '/status', :authorization => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end