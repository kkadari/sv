class ProfilePrivacyPayload

  def initialize(name_level, username, user_id, token, profile_fields = '')
    @name_level       = name_level
    @username         = username
    @user_id          = user_id
    @token            = token
    @profile_fields   = profile_fields
  end

  def payload
    payload = {
        'nameSecurityLevelID' => @name_level,
        'emailSecurityLevelID' => '1005',
        'imageSecurityLevelID' => '1005',
        'creationDateSecurityLevelID' => '1005',
        'lastLoginSecurityLevelID' => '1001',
        'save' => 'Save',
        'username' => @username,
        'targetUser' => @user_id,
        'jive.token.name' => 'edit.profile.security.' + @user_id,
        'edit.profile.security.' + @user_id => @token,
        :multipart => true
    }
    if @profile_fields != ''
      payload = payload.merge(@profile_fields)
    else
      payload += {
          'profile[5001].effectiveSecurityLevelID' => '1001', # These should be phased out.
          'profile[5004].effectiveSecurityLevelID' => '1001',
          #'profile[5005].effectiveSecurityLevelID' => '1005',
          'profile[5006].effectiveSecurityLevelID' => '1005',
          'profile[5007].effectiveSecurityLevelID' => '1005',
          'profile[5008].effectiveSecurityLevelID' => '1005',
          'profile[5009].effectiveSecurityLevelID' => '1005',
          #'profile[5010].effectiveSecurityLevelID' => '1001',
          'profile[5011].effectiveSecurityLevelID' => '1001',
          'profile[5012].effectiveSecurityLevelID' => '1005',
          'profile[5013].effectiveSecurityLevelID' => '1001',
          'profile[5015].effectiveSecurityLevelID' => '1001',
      }
      puts 'DEFAULT VALUES ... '
    end

    return payload
  end

end
