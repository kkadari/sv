Then /^as an admin I can view the anonymous discussion$/ do
  visit DiscussionSummaryPage, :using_params => {:id => @discussion_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  fail 'Incident report not anonymous' unless @browser.html.to_s.include? 'This content was posted anonymously by its author'
end

Then /^I can verify the anonymous identifiers have been added to the discussion$/ do
  visit DiscussionSummaryPage, :using_params => {:id => @discussion_id}

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  fail 'Discussion does not include Anonymous avatar' unless on(DiscussionSummaryPage).avatar.visible?
end