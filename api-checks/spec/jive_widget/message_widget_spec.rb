require 'spec_helper'

describe 'Create message widget' do

  it 'should return 200 when requesting the create message widget' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/directmessage/permissions', :cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return 200 when posting a new message to a user' do
    payload = '{"wallentry":{"message":"Delete this msg<br>","userIDs":["' + @id + '"],"subject":"Delete this msg","privateDM":true}}'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/wall/14/1',payload, {:cookie => @authorisation,:accept => 'application/json',:content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

end
