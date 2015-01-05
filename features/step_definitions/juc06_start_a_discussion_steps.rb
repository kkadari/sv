Given /^I have created? (?:a|an) (red|amber|green|white) discussion( question)?( anonymously)? in? (?:the|a) (community|private group|secret group|space)$/ do |marking, question, anonymous, location|
  @subject = on(HomePage).create_title_for('discussion')
  @marking = marking
  @location = location
  on(HomePage).create('discussion')
  on(DiscussionPage).set_ihm_level(@marking)
  on(DiscussionPage).set_publish_level(@location)
  if (question)
    on(DiscussionPage).mark_as_question
  end
  if (anonymous)
    on(DiscussionPage).raise_anonymously
  end
  on(DiscussionPage).complete_discussion :subject => @subject
  on(DiscussionSummaryPage).verify_content_exists(@subject)
  on(DiscussionSummaryPage).correct_ihm_displayed(@marking)
  if (anonymous)
    on(DiscussionSummaryPage).verify_anonymous
  end
end