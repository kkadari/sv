Given /^I have created? (?:a|an) (red|amber|green|white) poll in? (?:the|a) (community|private group|secret group|space)$/ do |marking, location|
  @subject = on(HomePage).create_title_for('poll')
  @marking = marking
  @location = location
  on(HomePage).create('poll')
  on(PollPage).set_ihm_level(@marking)
  on(PollPage).set_publish_level(@location)
  on(PollPage).complete_poll :subject => @subject
  on(PollSummaryPage).verify_content_exists(@subject)
  on(PollSummaryPage).correct_ihm_displayed(@marking)
end

Then(/^I can vote on the poll$/) do
  on(HomePage).click_content
  on(ContentPage).verify_poll_exists_with(@subject)
  on(ContentPage).navigate_to_poll_named(@subject)
  on(PollSummaryPage).vote_on_poll
  on(PollSummaryPage).confirm_vote
end