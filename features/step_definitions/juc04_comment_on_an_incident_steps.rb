Then /^I? (?:can|have)? (?:review|reviewed) the incident report( anonymously)?$/ do |anonymous|
  visit ViewIncidentReportPage, :using_params => {:id => @incident_id}

  on ViewIncidentReportPage do |review|
    review.three_star
    review.review
    review.wait_until do
      review.comment_container_element.attribute('style') =~ /23[0-9]/
    end
    review.enable_html_mode
    review.comment_body = 'An incident report review comment'
    review.check_anonymous if anonymous
    review.save
  end
end

Given /^I have mentioned "([^\"]+)" in an anonymous comment$/ do |user|
  visit ViewIncidentReportPage, :using_params => {:id => @incident_id}

  user_to_mention = "#{user}"
    case user_to_mention
      when 'participant A'
        on ViewIncidentReportPage do |comment|
          comment.comment
          comment.enable_html_mode
          comment.comment_body = 'This is a comment mentioning <body><p><a class="jive_macro jive_macro_user" href="javascript:;" jivemacro="user" ___default_attr="2002" data-objecttype="3" data-orig-content="Tim Durden">Tim Durden</a></p></body>'
          comment.check_anonymous
          comment.save
        end
      when 'participant B'
        on ViewIncidentReportPage do |comment|
          comment.comment
          comment.enable_html_mode
          comment.comment_body = 'This is a comment mentioning <body><p><a class="jive_macro jive_macro_user" href="javascript:;" jivemacro="user" ___default_attr="2013" data-objecttype="3" data-orig-content="simonwhi@surevine">simonwhi@surevine</a></p></body>'
          comment.check_anonymous
          comment.save
        end
      else
        fail 'Supplied user not recognised.'
    end
end