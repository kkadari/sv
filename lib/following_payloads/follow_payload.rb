class FollowPayload

  def initialize(object_type, object_id)
    @object_type = object_type.to_s
    @object_id   = object_id.to_s
  end

  def payload
    '[{"objectType":"' + @object_type + '","objectID":"' + @object_id + '"}]'
  end

end