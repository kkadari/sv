class PollPayload < Payload

  def initialize(cookie, subject, body, handling_level, choice_text, publication)
    @authorisation  = cookie
    @subject        = subject
    @body           = body
    @handling_level = handling_level
    @choice_text    = choice_text
    @publication    = publication
  end

  def payload
    RestClient.get('http://dev188.sure.vine/poll/create.jspa?sr=cmenu&containerType=2020&containerID=1024',:cookie => @authorisation){|response|
      @poll_id = response.body.scan(/name="pollID" value="([0-9]*)/).join(",")
    }

    RestClient.post('http://dev188.sure.vine/__services/v2/rest/polls/' + @poll_id + '/pollOptions','',:cookie => @authorisation){|response|
      @choice = response.body.scan(/"id" : ([0-9]*)\n/).join(",").to_i - 2
    }

    @options = ''

    2.times do |t|
      @options += '{
          "text": "' + @choice_text + ' ' + t.to_s + '",
          "ID": "' + (@choice - t).to_s + '",
          "index": "' + t.to_s + '"
      },'
    end

    '{
      "pollID": "' + @poll_id + '",
      "voteCount": "0",
      "subject": "' + @subject + '",
      "body": "<body><p>' + @body + '</p></body>",
      "options": [' + @options[0...-1] + '
      ],
      "handlingLevel": "' + set_ihm_level(@handling_level) + '",
      "publishBar":' + set_publish_bar(@publication) + ',
      "activeMode": "activenow",
      "endsMode": "endsnever",
      "endsDays": "14",
      "jiveTokenName": "jive.token.content.poll.create"
    }'
  end

end