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
      "jive":{
        "token":{
          "name":"jive.token.content.incidentReport.create",
          "content":{
            "incidentReport":{
              "create":"' + @token + '"
            }
          }
        }
      },
      "incidentReportID":"' + @incident_id + '",
      "subject":"=edited= ' + @subject + '",
      "body":"<body><p>' + @body + '</p></body>",
      "handlingLevel":"' + set_ihm_level(@handling_level) + '",
      "publishBar":' + set_publish_bar(@publication) + ',
      "moveNotifyStreams":false,
      "jiveTokenName":"jive.token.content.incidentReport.create"
    }'
  end

end
