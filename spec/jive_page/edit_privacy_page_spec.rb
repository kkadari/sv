require 'spec_helper'

describe 'Edit privacy page' do

  it 'should return a 200 when the page is requested' do
    RestClient.get(ENV['base_url'] + '/edit-profile-security!input.jspa?targetUser=' + @id,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting profile preview' do
    payload = 'nameSecurityLevelID=1005
              &emailSecurityLevelID=1005
              &profile%5B5004%5D.effectiveSecurityLevelID=1001
              &profile%5B5005%5D.effectiveSecurityLevelID=1005
              &profile%5B5006%5D.effectiveSecurityLevelID=1005
              &profile%5B5009%5D.effectiveSecurityLevelID=1005
              &profile%5B5008%5D.effectiveSecurityLevelID=1005
              &profile%5B5007%5D.effectiveSecurityLevelID=1005
              &profile%5B5002%5D.effectiveSecurityLevelID=1001
              &imageSecurityLevelID=1005
              &creationDateSecurityLevelID=1005
              &lastLoginSecurityLevelID=1001
              &username=stephaniek%40surevine
              &targetUser=' + @id + '
              &jive.token.name=edit.profile.security.' + @id + '
              &edit.profile.security.' + @id + '=1434553331436-E86MJFLU04FXQ4BVVD5T4EBT2N9SOYM0'

    RestClient.post(ENV['base_url'] + '/preview-profile.jspa',payload,{:cookie => @authorisation,:content_type => 'application/x-www-form-urlencoded'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when posting an update to privacy' do
    payload = 'nameSecurityLevelID=1005
              &emailSecurityLevelID=1005
              &profile%5B5004%5D.effectiveSecurityLevelID=1001
              &profile%5B5005%5D.effectiveSecurityLevelID=1005
              &profile%5B5006%5D.effectiveSecurityLevelID=1005
              &profile%5B5009%5D.effectiveSecurityLevelID=1005
              &profile%5B5008%5D.effectiveSecurityLevelID=1005
              &profile%5B5007%5D.effectiveSecurityLevelID=1005
              &profile%5B5002%5D.effectiveSecurityLevelID=1001
              &imageSecurityLevelID=1005
              &creationDateSecurityLevelID=1005
              &lastLoginSecurityLevelID=1001
              &username=stephaniek%40surevine
              &targetUser=' + @id + '
              &jive.token.name=edit.profile.security.' + @id + '
              &edit.profile.security.' + @id + '=1434553331436-E86MJFLU04FXQ4BVVD5T4EBT2N9SOYM0'

    RestClient.post(ENV['base_url'] + '/edit-profile-security.jspa',payload,{:cookie => @authorisation,:content_type => 'application/x-www-form-urlencoded'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end