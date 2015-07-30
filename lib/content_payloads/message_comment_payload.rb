class MessageCommentPayload < Payload

  def initialize(thread_id, discussion_id, subject, body, anonymous)
    @thread_id     = thread_id
    @discussion_id = discussion_id
    @subject       = subject
    @body          = body
    @anonymous     = anonymous
  end

  def payload
    '{
      "forumThreadID":"' + @thread_id + '",
      "ID":"' + @discussion_id + '",
      "subject":"' + @subject + '",
      "body":"<body><p>' + @body + '</p></body>",
      "notAttributable":' + convert_bool(@anonymous) + '
    }'
  end

end