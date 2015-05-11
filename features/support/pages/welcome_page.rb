require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class WelcomePage
  include PageObject
  include NavRibbon
  include UserModal
  extend UrlFactory

  page_url(welcomepage)

end