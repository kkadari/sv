require 'spec_helper'

describe 'Add ons page' do

  it 'should return a 200 when requested' do
    RestClient.get(ENV['base_url'] + '/apps-admin!input.jspa',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end