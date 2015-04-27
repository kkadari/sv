Then(/^I can vote on the poll$/) do
  on(HomePage).click_content
  on(ContentPage).verify_poll_exists_with(@subject)
  on(ContentPage).navigate_to_poll_named(@subject)
  on(PollSummaryPage).vote_on_poll
  on(PollSummaryPage).confirm_vote
end