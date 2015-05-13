Then /^I? (?:can|have)? (?:review|reviewed) the incident report( anonymously)?$/ do |anonymous|
  on(IncidentReportSummaryPage).navigate_directly_to_ir_with_id @incident_id

  if anonymous
    on(ViewIncidentReportPage).add_review_anonymously
  else
    on(ViewIncidentReportPage).add_review
  end
end

Given /^I have mentioned "([^\"]+)" in an anonymous comment$/ do |user|
  on(IncidentReportSummaryPage).navigate_directly_to_ir_with_id @incident_id
  user_to_mention = "#{user}"
    case user_to_mention
      when 'participant A'
        on(ViewIncidentReportPage).add_anon_comment_mentioning_tim
      when 'participant B'
        on(ViewIncidentReportPage).add_anon_comment_mentioning_simonwi
      else
        fail 'Supplied user not recognised.'
    end
end