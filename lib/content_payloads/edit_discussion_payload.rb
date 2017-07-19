class EditDiscussionPayload < Payload

  def initialize(token, thread, subject, body, author, handling_level, publication)
    @token          = token
    @thread         = thread
    @subject        = subject
    @body           = body
    @author         = author
    @handling_level = handling_level
    @publication    = publication
  end

  def payload
    '{
    	"mobileEditor": "false",
    	"cancelURL": "/message/1290?saved=true",
    	"jive": {
    		"token": {
    			"name": "jive.token.content.discussion.edit.7098b2ae-edeb-4590-9deb-091d97a2d8a1",
    			"content": {
    				"discussion": {
    					"edit": {
    						"' + @token + '"
    					}
    				}
    			}
    		}
    	},
    	"thread": "' + @thread + '",
    	"subject": "' + @subject + '",
    	"body": "<body><p>' + @body + '</p></body>",
    	"addComment": false,
    	"comment": "Message was edited by: ' + @author + '",
    	"handlingLevel": "' + set_ihm_level(@handling_level) + '",
    	"publishBar": ' + set_publish_bar(@publication) + ',
    	"moveNotifyStreams": false,
    	"notAttributable": "false",
    	"draft": "false",
    	"jiveTokenName": "jive.token.content.discussion.edit.7098b2ae-edeb-4590-9deb-091d97a2d8a1"
    }'
  end

end
