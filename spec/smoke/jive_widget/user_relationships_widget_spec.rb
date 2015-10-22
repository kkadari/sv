require 'spec_helper'

describe 'User relationships' do

  it 'should return a 200 when creating a new following label' do
    payload = '{"name":"Label here","css":"9e13aa"}'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/userrelationshiplists',payload,{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)

      $id = JSON.parse(response.body)['listID']
    }
  end

  it 'should return a 200 when getting a the details of a label' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/userrelationshiplists/' + $id,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 204 when adding a follower to a label' do
    RestClient.put(ENV['base_url'] + '/__services/v2/rest/userrelationshiplists/' + $id + '/members',@user_2_id,{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 204)
    }
  end

  it 'should return a 204 when deleting a label for a follower' do
    RestClient.delete(ENV['base_url'] + '/__services/v2/rest/userrelationshiplists/' + $id + '/members/' + @user_2_id,:cookie => @authorisation){|response|
      assert_code_and_body(response, 204)
    }
  end

  it 'should return a 204 when updating a following label' do
    payload = '{"name":"Updated label","css":"9e13aa"}'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/userrelationshiplists/' + $id,payload,{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 204)
    }
  end

  it 'should return a 204 when deleting a following label' do
    RestClient.delete(ENV['base_url'] + '/__services/v2/rest/userrelationshiplists/' + $id,:cookie => @authorisation){|response|
      assert_code_and_body(response, 204)
    }
  end

end
