require_relative './shared/shared_summary_items'

class PollSummaryPage
  include PageObject
  include SharedSummaryItems
  extend UrlFactory

  page_url(pollsummarypage)

  h1(:title, :css => '.j-poll-title h1')
  link(:breadcrumb, :href => "/groups/#{TestConfig.custom_group}/content?filterID=contentstatus[published]~objecttype~objecttype[poll]")

  radio_button(:first_poll_choice, :css => '.jive-poll-vote-list li:nth-child(1) input')

  link(:archive, :css => '#poll-archive-anchor a')
  div(:archive_confirmation, :id => 'jive-modal-archive-poll')
  div(:poll_ended, :id => 'j-poll-ended')

  button(:vote, :id => 'vote')
  button(:confirm_archive, :id => 'poll-archive-submit-button')
  span(:confirm_vote, :css => 'li.j-yourvote .j-check')

  div(:delete_confirmation, :id => 'jive-modal-delete-poll')
  button(:confirm_deletion, :id => 'poll-delete-submit-button')
  button(:confirm_delete, :id => 'poll-delete-submit-button')

end
