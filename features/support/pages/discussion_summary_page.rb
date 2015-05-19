class DiscussionSummaryPage
  include PageObject
  extend UrlFactory

  page_url(discussionsummarypage)
  
  image(:avatar, :class => 'jive-avatar anonymous-avatar')
  h1(:title, :css => '.js-original-header h1')
  link(:edit, :css => '#jive-link-edit a')

  link(:delete, :text => 'Delete')
  div(:delete_container, :class => 'jive-modal')
  button(:confirm_delete, :id => 'deletebutton')

  link(:export_to_pdf, :text => 'View as PDF')
  div(:ihm_bar, :class => 'ihmbar')
      
end
