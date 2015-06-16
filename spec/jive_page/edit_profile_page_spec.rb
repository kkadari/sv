require 'spec_helper'

describe 'Edit profile page' do

  it 'should return a 200 when requesting the edit profile page' do
    RestClient.get(ENV['base_url'] + '/edit-profile!input.jspa?targetUser=2012',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when sending a request to update the profile' do
    payload = {
        "profile[5005].typeID" => '8',
        "profile[5005].fieldID" => '5005',
        "profile[5005].value" => 'Analyst',
        "profile[5006].typeID" => '9',
        "profile[5006].fieldID" => '5006',
        "profile[5006].value"  => 'Ms.',
        "profile[5009].typeID"  => '11',
        "profile[5009].fieldID"  => '5009',
        "profile[5008].typeID"  => '11',
        "profile[5008].fieldID"  => '5008',
        "profile[5007].typeID" => '4',
        "profile[5007].fieldID" => '5007',
        "profile[5002].typeID" => '6',
        "profile[5002].fieldID" => '5002',
        "profile[5002].value"  => 'Details',
        "save"  => 'Save',
        "username" => 'stephaniek@surevine',
        "targetUser" => '2012',
        "jive.token.name" => 'edit.profile.2012',
        "edit.profile.2012" => '1434450629688-L7DIS7LESOF1JY7AV0CN17KA6Z9XP1J4',
        :multipart => true
    }

    RestClient.post(ENV['base_url'] + '/edit-profile.jspa',payload,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end