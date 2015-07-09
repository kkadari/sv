class CommentPayload

  def initialize(body, attributed)
    @body       = body
    @attributed = attributed.to_s
  end

  def payload
    '{
        "body":"<body><p>' + @body + '</p></body>",
        "mobileEditor":false,
        "commentMode":"comments",
        "attributed":' + @attributed + '
    }'
  end

end