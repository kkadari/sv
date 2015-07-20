Then /^I? (?:can|have)? (?:review|reviewed) the incident report( anonymously)?$/ do |anonymous|
  visit ViewIncidentReportPage, :using_params => {:id => @incident_id} do |review|
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
  visit_and_benchmark ViewIncidentReportPage, :using_params => {:id => @incident_id}

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

Given /^I mention "([^"]*)" in a normal comment on an incident report$/ do |user|
  subject = TitleCreator.create_title_for('incident')
  response = CreateContent.create_incident_report @browser.cookies.to_a, subject, 'Lorem ipsumy goodness', 'amber', Hash[:type => 'community'], "", false
  @incident_id = response['redirect'][/[0-9]+/,0]

  user_profile = TestConfig.return_profile(user)
  mention = '<p>This is a comment mentioning <a class=\'jive_macro jive_macro_user\' href=\'javascript:;\' jivemacro=\'user\' ___default_attr=\'2013\' data-objecttype=\'3\' data-orig-content=\'' + user_profile[:username] + '\'>' + user_profile[:username] + '</a></p>'

  payload = CommentPayload.new(mention,true).payload

  Comment.post_ir_comment(@incident_id, payload, @browser.cookies.to_a)
end

When /^I navigate to my inbox as "([^"]*)"$/ do |user|
  switch_user(user)
  sleep(2)

  response = Inbox.get_inbox(@browser.cookies.to_a)

  @message_id = Nokogiri::HTML.parse(response).at('.j-act-unread')['data-objectid']
  @comment_id = response.scan(/reports\/#{@message_id}#comment-[0-9]*/)[0].split('-')[1]
end

Then /^I will have received a notification that I was mentioned in an incident report$/ do
  payload = '{"originalIDs":[' + @comment_id + ']}'

  response = Inbox.post_for_message(@message_id, payload, @browser.cookies.to_a)

  @comment_json = JSON.parse(response.body)
end

Then /^the notification is attributed to "([^"]*)"$/ do |user|
  user_profile = TestConfig.return_profile(user)

  fail('Could not find commented users') unless @comment_json['items'][0]['activityUser']['subject'].include? user_profile[:username]
end