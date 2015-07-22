class UpdateCommentPayload < Payload

  def initialize(body)
    @body = body
  end

  def payload
    '{
        "body":"<body><p>' + @body + '</p></body>",
        "mobileEditor":false,
        "name":"",
        "email":"",
        "url":""
    }'
  end

end