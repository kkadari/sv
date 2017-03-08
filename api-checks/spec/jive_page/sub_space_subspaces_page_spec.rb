require 'spec_helper'

describe 'Sub Space subspaces' do

  it 'should return a 200 when requested' do
    RestClient.get(ENV['base_url'] + '/community/support/faq/places',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

end
