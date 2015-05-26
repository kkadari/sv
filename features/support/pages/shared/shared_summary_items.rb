module SharedSummaryItems
  include PageObject

  image(:avatar, :class => 'jive-avatar anonymous-avatar')

  link(:edit, :text => 'Edit')
  link(:delete, :text => 'Delete')

  div(:ihm_bar, :class => 'ihmbar')

  section(:original_message, :class => 'j-original-message')

  link(:comment, :text => 'Add a comment')
  text_area(:comment_content, :class => 'usertext')
  button(:submit, :name => 'post')

  link(:export_to_pdf, :text => 'View as PDF')

end