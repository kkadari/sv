class ViewDiscussionPage
  include PageObject
  extend UrlFactory

  page_url(viewdiscussionpage)
  
  link(:reply, :title => 'Reply to this message')
  link(:enable_html_mode, :id => 'wysiwygtext1_html')
  text_area(:comment_body, :class => 'usertext')
  checkbox(:anonymous, :id => 'attributed-check')
  button(:save, :text => 'Add Comment')

end
