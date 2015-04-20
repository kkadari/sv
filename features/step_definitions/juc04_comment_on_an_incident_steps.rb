Then /^I? (?:can|have)? (?:comment|commented) on the incident report( anonymously)?$/ do |anonymous|
  on(HomePage).navigate_to_ir_named(@subject)
  if (anonymous)
    on(ViewIncidentReportPage).add_comment_anonymously
  else
    on(ViewIncidentReportPage).add_comment
  end
end

Then /^I? (?:can|have)? (?:review|reviewed) the incident report( anonymously)?$/ do |anonymous|
  on(HomePage).navigate_to_ir_named(@subject)
  if (anonymous)
    on(ViewIncidentReportPage).add_review_anonymously
  else
    on(ViewIncidentReportPage).add_review
  end
end

Given /^I have mentioned "([^\"]+)" in an anonymous comment$/ do |user|
  on(HomePage).navigate_to_ir_named(@subject)
  user_to_mention = "#{user}"
    case user_to_mention
      when user_to_mention = 'participant A'
        on(ViewIncidentReportPage).add_anon_comment_mentioning_matt
      when user_to_mention = 'participant B'
        on(ViewIncidentReportPage).add_anon_comment_mentioning_tim
      else
        fail 'Supplied user not recognised.'
    end
end