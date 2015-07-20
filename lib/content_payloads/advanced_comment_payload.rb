class AdvancedCommentPayload

  def initialize(id, body, attributed)
    @id         = id
    @body       = body
    @attributed = attributed.to_s
  end

  def payload
    '{
        "mobileEditor":"false",
        "cancelURL":"/message/' + @id + '",
        "jive":{
          "token":{
            "name":"jive.token.content.comment.advanced",
            "content":{
              "comment":{
                "advanced":"1437389575696-BWQV2KXP81R6E5M4UVNUA9L7JC5FH3YR"
              }
            }
          }
        },
        "messageID":"' + @id + '",
        "body":"<body><p>' + @body + '</p></body>",
        "notAttributable":' + @attributed + ',
        "draft":"false",
        "draftID":"2756",
        "jiveTokenName":"jive.token.content.comment.advanced"
    }'
  end

end