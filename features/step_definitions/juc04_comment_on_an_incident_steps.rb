Then /^I? (?:can|have)? (?:review|reviewed) the incident report( anonymously)?$/ do |anonymous|
  visit ViewIncidentReportPage, :using_params => {:id => @incident_id}

  if anonymous
    on(ViewIncidentReportPage).add_review_anonymously
  else
    on(ViewIncidentReportPage).add_review
  end
end

Given /^I have mentioned "([^\"]+)" in an anonymous comment$/ do |user|
  visit ViewIncidentReportPage, :using_params => {:id => @incident_id}

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