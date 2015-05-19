class BlogPostSummaryPage
  include PageObject
  extend UrlFactory

  page_url(blogpostsummarypage)
  
  link(:edit_blog_button, :text => 'Edit')
  link(:delete, :text => /Delete/)
  button(:confirm_delete, :id => 'blogpost-delete-submit-button')
  link(:comment, :text => 'Add a comment')
  link(:edit, :id => 'wysiwyg_id_0_html')
  text_area(:comment_content, :class => 'usertext')
  button(:submit, :name => 'post')
  h1(:title, :css => '.jive-blog-post-subject-header h1')
  div(:delete_container, :class => 'jive-modal-content')
  div(:ihm_bar, :class => 'ihmbar')
  link(:export_to_pdf, :text => 'View as PDF')

end
