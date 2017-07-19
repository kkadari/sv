class AdvancedCommentPayload

  def initialize(id, body, attributed)
    @id         = id
    @body       = body
    @attributed = attributed.to_s
  end

  def payload
    '{
    	"mobileEditor": "false",
    	"cancelURL": "/thread/' + @id + '",
    	"jive": {
    		"token": {
    			"name": "jive.token.content.comment.advanced.2a424860-92da-42c9-82e9-e29363f5fb18",
    			"content": {
    				"comment": {
    					"advanced": {
    						"2a424860-92da-42c9-82e9-e29363f5fb18": "1500457038223-FCQ2QMXKRZ31HETLCBD4VVLJ1XWUF5QR"
    					}
    				}
    			}
    		}
    	},
    	"messageID": "' + @id + '",
    	"body": "<body><p>' + @body + '</p></body>",
    	"notAttributable": ' + @attributed + ',
    	"draft": "false",
    	"jiveTokenName": "jive.token.content.comment.advanced.2a424860-92da-42c9-82e9-e29363f5fb18"
    }'
  end

end
