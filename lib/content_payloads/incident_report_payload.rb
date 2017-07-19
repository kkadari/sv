class IncidentReportPayload < Payload

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
    			"name": "jive.token.content.incidentReport.create.847e05c3-2a9a-4ca0-bfc5-199e6bdcd482",
    			"content": {
    				"incidentReport": {
    					"create": {
    						"847e05c3-2a9a-4ca0-bfc5-199e6bdcd482": "1500458889867-F978E701C8PS156ZUZ1IXIRWF5H3NVA2"
    					}
    				}
    			}
    		}
    	},
    	"subject": "' + @subject + '",
    	"body": "<body><p>' + @body + '</p></body>",
    	"handlingLevel": "' + set_ihm_level(@handling_level) + '",
    	"publishBar": ' + set_publish_bar(@publication) + ',
    	"moveNotifyStreams": false,
    	"notAttributable": ' + convert_bool(@not_attributable) + ',
    	"draft": "false",
    	"draftID": "1011",
      "tags":"' + @tags + '",
    	"jiveTokenName": "jive.token.content.incidentReport.create.847e05c3-2a9a-4ca0-bfc5-199e6bdcd482"
    }'
  end
end
