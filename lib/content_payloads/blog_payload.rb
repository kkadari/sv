class BlogPayload < Payload

  def initialize(subject, body, handling_level, publication, tags)
    @subject           = subject
    @body              = body
    @handling_level    = handling_level
    @publication       = publication
    @tags              = tags
  end

  def payload
    '{
      "subject":"' + @subject + '",
      "body":"<body><p>' + @body + '</p></body>",
      "handlingLevel":"' + set_ihm_level(@handling_level) + '",
      "publishBar":{
        "visibility":"place",
        "container":{
          "objectType":"700",
          "objectID":"1004"
      },
      "commentStatus":"2",
      "blogPublishOption":false,
      "publishDate":{
          "selectedDate":"6/9/2015",
          "selectedHour":"1",
          "selectedMinute":"0",
          "selectedPeriod":"AM"
        }
      },
      "tags":"' + @tags + '",
      "jiveTokenName":"jive.token.content.blogpost.create"
    }'
  end

end