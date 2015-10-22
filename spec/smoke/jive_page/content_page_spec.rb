require 'spec_helper'

describe 'Content page' do

  it 'should return a 200 when requested' do
    RestClient.get(ENV['base_url'] + '/content',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end
