class ManageFollowPayload

  def initialize(user_id, entry_id, action)
    @user_id = user_id
    @entry_id = entry_id

    case(action)
      when 'accept'
        @id = '1'
      when 'reject'
        @id = '2'
      when 'ignore'
        @id = '3'
      else
        fail('Incorrect action given')
    end
  end

  def payload
    '{"userID":"' + @user_id + '","itemID":' + @entry_id + ',"actionCode":' + @id + ',"message":""}'
  end

end