Then /^I? (?:can|have)? (?:review|reviewed) the incident report( anonymously)?$/ do |anonymous|
  response = EditContent.get_edit_ir(@incident_id, $authorisation)
  token = Nokogiri::HTML.parse(response).css('input[name="jive.token.content.incidentReport.create"]')[0]['value']

  payload = EditIrPayload.new(token, @incident_id, '=edited= ' + @subject, '<body><p>Updated IR</p></body>', 'red', {:type => 'community'}).payload

  EditContent.put_edit_ir(@incident_id, payload, $authorisation)
end

Given /^I have mentioned "([^\"]+)" in an anonymous comment$/ do |user|
  user_profile = TestConfig.return_profile(user)
  mention = '<p>This is a comment mentioning <a class=\'jive_macro jive_macro_user\' href=\'javascript:;\' jivemacro=\'user\' ___default_attr=\'2007\' data-objecttype=\'3\' data-orig-content=\'' + user_profile[:username] + '\'>' + user_profile[:username] + '</a></p>'

  payload = CommentPayload.new(mention,false).payload

  Comment.post_ir_comment(@incident_id, payload, $authorisation)
end

Given /^I mention "([^"]*)" in a normal comment on an incident report$/ do |user|
  subject = TitleCreator.create_title_for('incident')

  payload = IncidentReportPayload.new(subject,false,'Lorem ipsumy goodness','amber',{:type => 'community'},'',false).payload
  response = CreateContent.create_incident_report(payload, $authorisation)
  @incident_id = response['redirect'][/[0-9]+/,0]

  user_profile = TestConfig.return_profile(user)
  mention = '<p>This is a comment mentioning <a class=\'jive_macro jive_macro_user\' href=\'javascript:;\' jivemacro=\'user\' ___default_attr=\'2007\' data-objecttype=\'3\' data-orig-content=\'' + user_profile[:username] + '\'>' + user_profile[:username] + '</a></p>'

  payload = CommentPayload.new(mention,true).payload

  Comment.post_ir_comment(@incident_id, payload, $authorisation)
end

When /^I navigate to my inbox as "([^"]*)"$/ do |user|
  5.times do |i|
    begin
      switch_user(user)

      response = Inbox.get_inbox($authorisation)

      @message_id = Nokogiri::HTML.parse(response).at('.j-act-unread')['data-objectid']
      @comment_id = response.scan(/reports\/#{@message_id}#comment-[0-9]*/)[0].split('-')[1]
      break
    rescue => e
      if i < 5
        sleep(1)
      else
        fail(e)
      end
    end
  end
end

Then /^I will have received a notification that I was mentioned in an incident report$/ do
  payload = '{"originalIDs":[' + @comment_id + ']}'
  response = Inbox.post_for_message(@message_id, payload, $authorisation)
  @comment_json = JSON.parse(response.body)
end

Then /^the notification is attributed to "([^"]*)"$/ do |user|
  user_profile = TestConfig.return_profile(user)

  fail('Could not find commented users') unless @comment_json['items'][0]['activityUser']['subject'].include? user_profile[:username]
end
