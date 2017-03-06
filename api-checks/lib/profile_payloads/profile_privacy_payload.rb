class ProfilePrivacyPayload

  def initialize(name_level, username, user_id, token, profile_fields)
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
    payload = payload.merge(@profile_fields)

    return payload
  end

end
