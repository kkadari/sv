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
    	"mobileEditor": "false",
    	"cancelURL": "/polls/3271?saved=true",
    	"jive": {
    		"token": {
    			"name": "jive.token.content.poll.edit.ef8711bd-1bfc-4b64-adae-f132a3940fea",
    			"content": {
    				"poll": {
    					"edit": {
    						"' + @token + '"
    					}
    				}
    			}
    		}
    	},
    	"pollID": "' + @poll_id + '",
    	"voteCount": "0",
    	"subject": "' + @subject + '",
    	"body": "<body><p>' + @body + '</p></body>",
    	"options": [{
    		"text": "' + @choice_text + ' 1",
    		"ID": "5594",
    		"index": "0"
    	}, {
    		"text": "' + @choice_text + ' 2",
    		"ID": "5595",
    		"index": "1"
    	}],
    	"handlingLevel": "2",
    	"publishBar": {
    		"visibility": "all",
    		"pollVoteOptions": false
    	},
    	"moveNotifyStreams": false,
    	"activeMode": "activenow",
    	"endsMode": "endsnever",
    	"endsDays": "14",
    	"draft": "false",
    	"jiveTokenName": "jive.token.content.poll.edit.ef8711bd-1bfc-4b64-adae-f132a3940fea"
    }'
  end

end
