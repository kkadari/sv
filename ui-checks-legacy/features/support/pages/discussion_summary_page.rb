require_relative './shared/shared_summary_items'

class DiscussionSummaryPage
  include PageObject
  include SharedSummaryItems
  extend UrlFactory

  page_url(discussionsummarypage)

  h1(:title, :css => '.js-original-header h1')

  div(:delete_container, :class => 'jive-modal')
  button(:confirm_delete, :id => 'deletebutton')

end
