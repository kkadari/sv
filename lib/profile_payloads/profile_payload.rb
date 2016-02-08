class ProfilePayload

  def initialize(prefix, phone_1, phone_2, email, sentence, username, user_id, token)
    @prefix   = prefix
    @phone_1  = phone_1
    @phone_2  = phone_2
    @email    = email
    @sentence = sentence
    @username = username
    @user_id  = user_id
    @token    = token
  end

  def payload
    {
        'profile[5005].typeID'  => '8',
        'profile[5005].fieldID'  => '5005',
        'profile[5005].value'  => 'Analyst',
        'profile[5006].typeID'  => '9',
        'profile[5006].fieldID'  => '5006',
        'profile[5006].value'  => @prefix,
        'profile[5009].typeID'  => '11',
        'profile[5009].fieldID'  => '5009',
        'profile[5009].phoneNumbers[0].phoneNumber'  => @phone_1,
        'profile[5009].phoneNumbers[0].typeString'  => 'other',
        'profile[5008].typeID'  => '11',
        'profile[5008].fieldID'  => '5008',
        'profile[5008].phoneNumbers[0].phoneNumber'  => @phone_2,
        'profile[5008].phoneNumbers[0].typeString'  => 'other',
        'profile[5007].typeID'  => '4',
        'profile[5007].fieldID'  => '5007',
        'profile[5007].emails[0].email'  => @email,
        'profile[5007].emails[0].typeString'  => 'other',
        'profile[5010].typeID'  => '6',
        'profile[5010].fieldID'  => '5010',
        'profile[5010].value'  => @sentence,
        'save'  => 'Save',
        'username'  => @username,
        'targetUser'  => '2019',
        'jive.token.name'  => 'edit.profile.' + @user_id,
        'edit.profile.' + @user_id  => @token,
        :multipart => true
    }
  end

end
