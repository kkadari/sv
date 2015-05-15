require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class UserOneActivityStreamPage
  include PageObject
  extend UrlFactory

  page_url(useroneactivitystreampage)

  divs(:comments, :class => 'j-act-comment')
  links(:show_all, :class => 'j-js-show-all j-expand')

end
