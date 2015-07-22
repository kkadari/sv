class CommentPayload

  def initialize(body, attributed, comment_id = 0)
    @body       = body
    @attributed = attributed.to_s
    @comment_id = comment_id.to_s
  end

  def payload
    payload = '{"body":"<body><p>' + @body + '</p></body>","mobileEditor":false,'

    payload += '"parentCommentID":"' + @comment_id + '",' if @comment_id != '0'

    payload += '"commentMode":"comments","attributed":' + @attributed + '}'

    return payload
  end

end