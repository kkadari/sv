class PollSummaryPage
  include PageObject
  extend UrlFactory

  page_url(pollsummarypage)
  
  link(:edit_poll_button, :text => /Edit/)
  link(:delete, :text => 'Delete')
  button(:confirm_delete, :id => 'poll-delete-submit-button')
  link(:comment, :text => 'Add a comment')
  link(:edit, :text => 'Edit')
  text_area(:comment_content, :class => 'usertext')
  button(:submit, :name => 'post')
  link(:breadcrumb, :href => "/groups/#{TestConfig.custom_group}/content?filterID=contentstatus[published]~objecttype~objecttype[poll]")

  link(:archive, :css => '#poll-archive-anchor a')
  div(:archive_confirmation, :id => 'jive-modal-archive-poll')

  button(:vote, :id => 'vote')

  button(:confirm_archive, :id => 'poll-archive-submit-button')
  span(:confirm_vote, :css => 'li.j-yourvote .j-check')

  div(:poll_ended, :id => 'j-poll-ended')

  radio_button(:first_poll_choice, :css => '.jive-poll-vote-list li:nth-child(1) input')
  button(:vote, :id => 'vote')

  h1(:title, :css => '.j-poll-title h1')

  div(:delete_confirmation, :id => 'jive-modal-delete-poll')
  button(:confirm_deletion, :id => 'poll-delete-submit-button')

  div(:ihm_bar, :class => 'ihmbar')

end
