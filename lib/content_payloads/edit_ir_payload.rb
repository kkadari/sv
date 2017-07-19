class EditIrPayload < Payload

  def initialize(token, incident_id, subject, body, handling_level, publication)
    @token             = token
    @incident_id       = incident_id
    @subject           = subject
    @body              = body
    @handling_level    = handling_level
    @publication       = publication
  end

  def payload
    '{
    	"mobileEditor": "false",
    	"cancelURL": "/welcome",
    	"jive": {
    		"token": {
    			"name": "jive.token.content.incidentReport.create.1af569ba-8d46-43a1-b905-a9642d31dd31",
    			"content": {
    				"incidentReport": {
    					"create": {
    						"' + @token + '"
    					}
    				}
    			}
    		}
    	},
    	"incidentReportID": "' + @incident_id + '",
    	"subject": "=edited= ' + @subject + '",
    	"body": "<body><p>' + @body + '</p></body>",
    	"handlingLevel": "' + set_ihm_level(@handling_level) + '",
    	"publishBar": ' + set_publish_bar(@publication) + ',
    	"moveNotifyStreams": false,
    	"tags": "test, test2",
    	"notAttributable": "false",
    	"draft": "false",
    	"jiveTokenName": "jive.token.content.incidentReport.create.1af569ba-8d46-43a1-b905-a9642d31dd31"
    }'
  end

end
