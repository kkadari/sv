class BlogPayload < Payload

  def initialize(subject, body, handling_level, tags)
    @subject           = subject
    @body              = body
    @handling_level    = handling_level
    @tags              = tags
  end

  def payload
    '{
      "subject":"' + @subject + '",
      "body":"<body><p>' + @body + '</p></body>",
      "handlingLevel":"' + set_ihm_level(@handling_level) + '",
      "publishBar": {
          "visibility": "all",
          "commentStatus": "2",
          "blogPublishOption": false,
          "publishDate": { }
      },
      "moveNotifyStreams": false
    }'
  end

end
