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
          "publishDate": {
              "selectedDate": "6/26/2015",
              "selectedHour": "1",
              "selectedMinute": "0",
              "selectedPeriod": "AM"
          }
      },
      "moveNotifyStreams": false
    }'
  end

end
