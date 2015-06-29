class UserOneActivityStreamPage
  include PageObject
  extend UrlFactory

  page_url(useroneactivitystreampage)

  div(:comment, :class => 'j-act-comment')
  link(:show_all, :class => 'j-js-show-all j-expand')

end
