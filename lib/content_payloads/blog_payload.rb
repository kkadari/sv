class BlogPayload < Payload

  def initialize(subject, body, handling_level, tags, blog_name = '')
    @subject           = subject
    @body              = body
    @handling_level    = handling_level
    @tags              = tags
    @blog_name         = blog_name
  end

  def payload
    payload = '{
    	"mobileEditor": "false",
    	"cancelURL": "/welcome",
    	"jive": {
    		"token": {
    			"name": "jive.token.content.blogpost.create.eb064ac1-3eac-4253-97c6-f9b4f2e2de84",
    			"content": {
    				"blogpost": {
    					"create": {
    						"eb064ac1-3eac-4253-97c6-f9b4f2e2de84": "1500457267299-2LE536KFMMP0L76KHXKQEWOPMSV2RO2A"
    					}
    				}
    			}
    		}
    	},
    	"subject": "' + @subject + '",
    	"body": "<body><p>' + @body + '</p></body>",
    	"handlingLevel": "' + set_ihm_level(@handling_level) + '",
      "publishBar": {
    		"visibility": "place",
    		"container": {
    			"objectType": "14",
    			"objectID": "2004"
    		},
    		"commentStatus": "2",
    		"blogPublishOption": false,
    		"publishDate": {
    			"selectedDate": "20/07/2017",
    			"selectedHour": "0",
    			"selectedMinute": "0"
    		}
    	},
    	"moveNotifyStreams": false,
    	"draft": "false",
    	"jiveTokenName": "jive.token.content.blogpost.create.eb064ac1-3eac-4253-97c6-f9b4f2e2de84"
    }'

    return payload
  end

end
