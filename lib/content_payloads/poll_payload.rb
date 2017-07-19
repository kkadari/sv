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
    	"mobileEditor": "false",
    	"cancelURL": "/welcome",
    	"jive": {
    		"token": {
    			"name": "jive.token.content.poll.create.03a39720-4a9f-48ac-be1a-e8881e110469",
    			"content": {
    				"poll": {
    					"create": {
    						"03a39720-4a9f-48ac-be1a-e8881e110469": "1500459139825-BBI2MJLCNRSQYVLVM7BTNJNX925WTY2S"
    					}
    				}
    			}
    		}
    	},
    	"pollID": "' + @poll_id + '",
    	"voteCount": "0",
    	"subject": "' + @subject + '",
    	"body": "<body><p>' + @body + '</p></body>",
    	"options": [' + @options[0...-1] + '],
    	"handlingLevel": "' + set_ihm_level(@handling_level) + '",
    	"publishBar": ' + set_publish_bar(@publication) + ',
    	"moveNotifyStreams": false,
    	"activeMode": "activenow",
    	"endsMode": "endsnever",
    	"endsDays": "14",
    	"draft": "false",
    	"draftID": "1013",
    	"jiveTokenName": "jive.token.content.poll.create.03a39720-4a9f-48ac-be1a-e8881e110469"
    }'
  end

end
