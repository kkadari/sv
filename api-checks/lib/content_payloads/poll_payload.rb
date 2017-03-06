class PollPayload < Payload

  def initialize(cookie, poll_id, choice, subject, body, handling_level, choice_text, publication)
    @authorisation  = cookie
    @poll_id        = poll_id
    @choice         = choice.to_i - 2
    @subject        = subject
    @body           = body
    @handling_level = handling_level
    @choice_text    = choice_text
    @publication    = publication
  end

  def payload
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
