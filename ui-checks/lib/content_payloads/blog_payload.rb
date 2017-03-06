class BlogPayload < Payload

  def initialize(subject, body, handling_level, tags, blog_name = '')
    @subject           = subject
    @body              = body
    @handling_level    = handling_level
    @tags              = tags
    @blog_name         = blog_name
  end

  def payload

    blog_name = ENV['username'] || @blog_name # used to set Blog Name

    payload = '{
      "subject":"' + @subject + '",
      "body":"<body><p>' + @body + '</p></body>",
      "handlingLevel":"' + set_ihm_level(@handling_level) + '",
      "publishBar": {
          "visibility": "all",
          "commentStatus": "2",
          "personalBlogName": "' + blog_name + '\'s Blog",
          "blogPublishOption": false,
          "publishDate": { }
      },
      "moveNotifyStreams": false
    }'
    return payload
  end

end
