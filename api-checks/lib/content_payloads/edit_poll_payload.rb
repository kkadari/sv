class EditPollPayload < Payload

  def initialize(token, poll_id, subject, body, choice_text)
    @token = token
    @poll_id = poll_id
    @subject = subject
    @body = body
    @choice_text = choice_text
  end

  def payload
    '{
      "mobileEditor":"false",
      "jive":{
        "token":{
          "name":"jive.token.content.poll.edit",
          "content":{
            "poll":{
              "edit":"' + @token + '"
            }
          }
        }
      },
      "pollID":"' + @poll_id + '",
      "voteCount":"0",
      "subject":"' + @subject + '",
      "body":"<body><p>' + @body + '</p></body>",
      "options":[{
          "text":"' + @choice_text + ' 1",
          "ID":"3517",
          "index":"0"
        },{
          "text":"'  + @choice_text + ' 0",
          "ID":"3518",
          "index":"1"
      }],
      "handlingLevel":"3",
      "publishBar":{
        "visibility":"all",
        "pollVoteOptions":true
      },
      "moveNotifyStreams":false,
      "activeMode":"activenow",
      "endsMode":"endsnow",
      "endsDays":"14",
      "draft":"false",
      "draftID":"2876",
      "jiveTokenName":"jive.token.content.poll.edit"
    }'
  end

end
