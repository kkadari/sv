class DiscussionPayload < Payload

  def initialize(subject, question, body, handling_level, publication, tags, not_attributable)
    @subject           = subject
    @question          = question
    @body              = body
    @handling_level    = handling_level
    @publication       = publication
    @tags              = tags
    @not_attributable  = not_attributable
  end

  def payload
    '{
    	"mobileEditor": "false",
    	"cancelURL": "/welcome",
    	"jive": {
    		"token": {
    			"name": "jive.token.content.discussion.create.f5d05455-8a71-4717-8946-23ecd9ea5780",
    			"content": {
    				"discussion": {
    					"create": {
    						"f5d05455-8a71-4717-8946-23ecd9ea5780": "1500457847617-G4QRNY6VGG4EUC0KJU8T4J6MUE8LZUTY"
    					}
    				}
    			}
    		}
    	},
    	"subject": "' + @subject + '",
    	"markAsQuestion": ' + convert_bool(@question) + ',
    	"body": "<body><p>' + @body + '</p></body>",
    	"handlingLevel": "' + set_ihm_level(@handling_level) + '",
    	"publishBar": ' + set_publish_bar(@publication) + ',
      "tags":"' + @tags + '",
      "notAttributable": ' + convert_bool(@not_attributable) + ',
    	"moveNotifyStreams": false,
    	"notAttributable": false,
    	"draft": "false",
    	"jiveTokenName": "jive.token.content.discussion.create.f5d05455-8a71-4717-8946-23ecd9ea5780"
    }'
  end

end
