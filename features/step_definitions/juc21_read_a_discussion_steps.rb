Then /^as an admin I can view the anonymous discussion$/ do
  on(HomePage).click_content
  on(ContentPage).navigate_to_discussion_named(@subject)
  on(DiscussionSummaryPage).verify_content_exists(@subject)
  on(DiscussionSummaryPage).verify_anonymous
end

Then /^I can verify the anonymous identifiers have been added to the discussion$/ do
  on(HomePage).click_content
  on(ContentPage).navigate_to_discussion_named(@subject)
  on(DiscussionSummaryPage).verify_content_exists(@subject)
  on(DiscussionSummaryPage).verify_anonymous_as_participant
end