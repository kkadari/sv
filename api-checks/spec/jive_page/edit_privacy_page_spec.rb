require 'spec_helper'

describe 'Edit privacy page' do

  it 'should return a 200 when the page is requested' do
    RestClient.get(ENV['base_url'] + '/edit-profile-security!input.jspa?targetUser=' + @id,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting profile preview' do

    @username = CGI.escape('admin')

    payload = 'nameSecurityLevelID=1001
              &emailSecurityLevelID=1001
              &profile[5004].effectiveSecurityLevelID=1001
              &profile[5005].effectiveSecurityLevelID=1005
              &profile[5006].effectiveSecurityLevelID=1005
              &profile[5007].effectiveSecurityLevelID=1005
              &profile[5008].effectiveSecurityLevelID=1005
              &profile[5009].effectiveSecurityLevelID=1005
              &profile[5010].effectiveSecurityLevelID=1001
              &profile[5011].effectiveSecurityLevelID=1001
              &profile[5012].effectiveSecurityLevelID=1005
              &profile[5013].effectiveSecurityLevelID=1001
              &imageSecurityLevelID=1003
              &creationDateSecurityLevelID=1001
              &lastLoginSecurityLevelID=1001
              &username=' + @username + '
              &targetUser=' + @id + '
              &jive.token.name=edit.profile.security.' + @id + '
              &edit.profile.security.' + @id + '=1434553331436-E86MJFLU04FXQ4BVVD5T4EBT2N9SOYM0'

    RestClient.post(ENV['base_url'] + '/preview-profile.jspa',payload,{:cookie => @authorisation,:content_type => 'application/x-www-form-urlencoded'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when posting an update to privacy' do

    # Get User ID
    RestClient.get(ENV['base_url'] + '/api/core/v3/people/@me', :cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
      @user_id = JSON.parse(response.split(';',0)[1])['id']
    }

    # Get Privacy Profile for User (HTML response)
    response = Profile.get_edit_privacy_profile(@id, @authorisation)

    # Extract profile fields and current values (so we can build our payload)
    fields = Hash.new()
      Nokogiri::HTML(response).xpath('//select[starts-with(@name, "profile[")]').each do |items|
        field_name = items.attributes['name'].value
        s = '#' + items.attributes['id'].value + ' option[@selected="selected"]'
        selected_value =  Nokogiri::HTML(response).css(s).attr('value').to_s
        fields[field_name] = selected_value
      end
    token = Nokogiri::HTML(response).css('input[name*="edit.profile.security"]')[0]['value']
    name_level = '100' + (2 * rand(3) + 1).to_s
    username = CGI.escape('admin')

    payload = ProfilePrivacyPayload.new(name_level, username, @user_id, token, fields).payload

    # Post privacy update
    RestClient.post(ENV['base_url'] + '/edit-profile-security.jspa', payload, {:cookie => @authorisation}){|response|
      assert_code_and_body(response, 302)
    }

  end

end
