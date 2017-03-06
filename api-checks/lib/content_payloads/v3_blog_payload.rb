class V3BlogPayload < Payload

  def initialize(subject, body, handling_level, tags)
    @subject           = subject
    @body              = body
    @handling_level    = handling_level
    @tags              = tags
  end

  def payload
    '{
      "subject": "' + @subject + '",
      "type": "post",
      "content": {
          "type": "text/html",
          "text": "<body><p>' + @body + '</p></body>"},
          "handlingLevel": "' + set_ihm_level(@handling_level) + '"
      }
    }'
  end

end

