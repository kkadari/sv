Then /^as an admin I can view the anonymous discussion$/ do
  visit_and_benchmark DiscussionSummaryPage, :using_params => {:id => @discussion_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  fail 'Incident report not anonymous' unless @browser.html.to_s.include? 'This content was posted anonymously by its author'
end

Then /^I can verify the anonymous identifiers have been added to the discussion$/ do
  visit_and_benchmark DiscussionSummaryPage, :using_params => {:id => @discussion_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  fail 'Discussion does not include Anonymous avatar' unless on(DiscussionSummaryPage).avatar_element.visible?
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