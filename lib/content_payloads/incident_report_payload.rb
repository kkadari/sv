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
      "subject":"' + @subject + '",
      "body":"<body><p>' + @body + '</p></body>",
      "handlingLevel":"' + set_ihm_level(@handling_level) + '",
      "publishBar":' + set_publish_bar(@publication) + ',
      "tags":"' + @tags + '",
      "notAttributable": ' + convert_bool(@not_attributable) + '
    }'
  end
end