Given /^I am viewing an anonymous incident report as "([^"]*)"$/ do |user|
  switch_user(user)

  subject = TitleCreator.create_title_for('incident')

  payload = IncidentReportPayload.new(subject,false,'Lorem ipsumy goodness','green',{:type => 'community'},'auto',true).payload
  response = CreateContent.create_incident_report(payload, @browser.cookies.to_a)
  @incident_id = response['redirect'][/[0-9]+/,0]
end

Given /^I have posted an anonymous review and rating for the incident$/ do
  Rating.post_ir_rating(@incident_id,'5',@browser.cookies.to_a)

  payload = CommentPayload.new('Auto comment',false).payload
  Comment.post_ir_comment(@incident_id, payload, @browser.cookies.to_a)
end

When /^I view the incident report as "([^"]*)"$/ do |user|
  switch_user(user)

  @rating_response = Rating.get_ir_rating(@incident_id, @browser.cookies.to_a)
  @comments_response = Comment.get_ir_comments(@incident_id, @browser.cookies.to_a)
end

Then /^I can view the anonymous review of the incident report$/ do
  html = Nokogiri::HTML.parse(@comments_response)

  fail('Comment not anonymous') unless html.css('.jive-comment-add-threaded')[0]['commentusername']  == 'Anonymous'
  fail('Comment not found') unless html.css('div[id*="comment-body-"]').text.include? 'Auto comment'
end

Then /^the rating is displayed correctly$/ do
  fail('Rating not set') unless JSON.parse(@rating_response)['ratingInfo']['availableRatingCount'] == 5
end

Given /^I am viewing an incident report as "([^"]*)"$/ do |user|
  switch_user(user)

  subject = TitleCreator.create_title_for('incident')

  payload = IncidentReportPayload.new(subject, false, 'Lorem ipsumy goodness', 'green', {:type => 'community'}, 'auto', false).payload
  response = CreateContent.create_incident_report(payload, @browser.cookies.to_a)
  @incident_id = response['redirect'][/[0-9]+/,0]
end

Given /^I have posted a review and rating for the incident$/ do
  Rating.post_ir_rating(@incident_id,'5',@browser.cookies.to_a)

  payload = CommentPayload.new('Auto comment',true).payload
  Comment.post_ir_comment(@incident_id, payload, @browser.cookies.to_a)
end

Then /^I can view the review of the incident report$/ do
  html = Nokogiri::HTML.parse(@comments_response)

  fail('Comment is anonymous') if html.css('.jive-comment-add-threaded')[0]['commentusername']  == 'Anonymous'
  fail('Comment not found') unless html.css('div[id*="comment-body-"]').text.include? 'Auto comment'
end
