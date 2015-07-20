class V3GroupPayload < Payload

  def initialize(display_name, name, type)
    @display_name = display_name
    @name        = name
    @type        = type
  end

  def payload
    '{
      "type":"group",
      "displayName":"' + @display_name + '",
      "name":"' + @name + '",
      "groupType":"' + @type + '"
    }'
  end

end