require 'spec_helper'

describe 'Actions page' do

  it 'should return a 200 when requesting the actions view' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/action-queue/initializeView?tabID=',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when toggling the actions view between active and resolved' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/action-queue/list/marked?type=resolved',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }

    RestClient.get(ENV['base_url'] + '/__services/v2/rest/action-queue/list/marked?type=active',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end