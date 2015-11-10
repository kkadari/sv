class ProfilePrivacyPayload

  def initialize(name_level, username, user_id, token)
    @name_level = name_level
    @username   = username
    @user_id    = user_id
    @token      = token
  end

  def payload
    {
        'nameSecurityLevelID' => @name_level,
        'emailSecurityLevelID' => '1005',
        'profile[5004].effectiveSecurityLevelID' => '1001',
        'profile[5005].effectiveSecurityLevelID' => '1001',
        'profile[5006].effectiveSecurityLevelID' => '1005',
        'profile[5009].effectiveSecurityLevelID' => '1005',
        'profile[5008].effectiveSecurityLevelID' => '1005',
        'profile[5007].effectiveSecurityLevelID' => '1005',
        'profile[5002].effectiveSecurityLevelID' => '1001',
        'profile[5010].effectiveSecurityLevelID' => '1001',
        'profile[5012].effectiveSecurityLevelID' => '1001',
        'profile[5013].effectiveSecurityLevelID' => '1001',
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
  end
end
