require 'spec_helper'

describe 'Group membership widget' do

  it 'should return a 200 when joining a group' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/socialgroups/' + @group_id + '/members','',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting to leave a group' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/socialgroups/' + @group_id + '/memberInfo',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  # Commenting out test until I can work out how to easily add the user back to the group at a later date

  # it 'should return a 204 when leaving a group' do
  #   RestClient.delete(ENV['base_url'] + '/__services/v2/rest/socialgroups/' + @group_id + '/members',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
  #     fail('Failed with ' + response.code.to_s) if response.code != 204
  #   }
  # end

  it 'should return a 200 when returning a members list of a group' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/activity/users/membership/700/' + @group_id,{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end