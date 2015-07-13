class FollowPayload

  def initialize(user_id)
    @user_id = user_id
  end

  def payload
    '[{"objectType":"3","objectID":"' + @user_id + '"}]'
  end

end