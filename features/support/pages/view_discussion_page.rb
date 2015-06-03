class ViewDiscussionPage
  include PageObject
  extend UrlFactory

  page_url(viewdiscussionpage)

  h1(:title, :css => '.js-original-header h1')
  link(:reply, :title => 'Reply to this message')
  link(:enable_html_mode, :id => 'wysiwygtext1_html')
  text_area(:comment_body, :class => 'usertext')
  span(:anonymous, :css => '#attributed-wrapper-discussion span')
  button(:save, :css => '#postform > div:nth-child(15) > input.jive-form-button-save')

end
