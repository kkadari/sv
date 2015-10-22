require 'spec_helper'

describe 'Following widget' do

  it 'should return a 200 when requesting the following widget' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/stream-config/user/associations/manage',
                    '[{"objectType":3,"objectID":' + @user_2_id + '}]',
                    {:cookie => @authorisation,:content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting to unfollow a user in all feeds' do
    RestClient.delete(ENV['base_url'] + '/__services/v2/rest/stream-config/3/' + @user_2_id,:cookie => @authorisation){|response|
      assert_code_and_body(response, 204)
    }
  end

  it 'should return a 200 when requesting to follow a user in a specific feed' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/stream-config/11/objects',
                    '[{"objectType":3,"objectID":' + @user_2_id + '}]',
                    {:cookie => @authorisation,:content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting to unfollow a user in a specific feed' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/stream-config/11/objects/remove',
                    '[{"objectType":3,"objectID":' + @user_2_id + '}]',
                    {:cookie => @authorisation,:content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

end
