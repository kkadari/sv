require 'spec_helper'

describe 'User connections widget' do

  it 'should return a 200 when requesting what users a person follows' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/activity/users/connections/3/' + @user_2_id,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end
