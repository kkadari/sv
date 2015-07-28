Then /^as an admin I can view the anonymous discussion$/ do
  visit_and_benchmark DiscussionSummaryPage, :using_params => {:id => @discussion_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  fail 'Incident report not anonymous' unless @browser.html.to_s.include? 'This content was posted anonymously by its author'
end

Then(/^I can view the discussion$/) do
  on(DiscussionSummaryPage).wait_until do
    on(DiscussionSummaryPage).title?
  end

  fail 'Title not visible' unless on(DiscussionSummaryPage).title?
  fail 'IHM not visible' unless on(DiscussionSummaryPage).ihm_bar?
  fail 'Body not visible' unless on(DiscussionSummaryPage).original_message?
  fail 'Comment not visible' unless on(ViewDiscussionPage).reply?
end

When /^I attempt to view a discussion that has recently been deleted$/ do
  switch_user('admin')

  response = CreateContent.create_discussion @browser.cookies.to_a, 'Discussion for deletion', false, 'Lorem ipsumy goodness', 'amber', Hash[:type => 'community'], '', true
  @discussion_id = response['redirect'][/[0-9]+/,0]

  DeleteContent.delete_discussion(@discussion_id, @browser.cookies.to_a)
end

Then /^the system displays a 'Not Found' error message$/ do
  switch_user('participant A')

  Content.get_message(@discussion_id, @browser.cookies.to_a, 404)
end