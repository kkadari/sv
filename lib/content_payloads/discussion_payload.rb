class DiscussionPayload < Payload

  def initialize(subject, question, body, handling_level, publication, not_attributable)
    @subject           = subject
    @question          = question
    @body              = body
    @handling_level    = handling_level
    @publication       = publication
    @not_attributable  = not_attributable
  end

  def payload
    '{
      "subject":"' + @subject + '",
      "markAsQuestion": ' + convert_bool(@question) + ',
      "body":"<body><p>' + @body + '</p></body>",
      "handlingLevel":"' + set_ihm_level(@handling_level) + '",
      "publishBar":' + set_publish_bar(@publication) + ',
      "notAttributable": ' + convert_bool(@not_attributable) + '
    }'
    end

end