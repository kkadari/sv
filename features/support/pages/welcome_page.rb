require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class WelcomePage
  include PageObject
  include FigNewton
  include NavRibbon
  include UserModal

  page_url("#{FigNewton.base_url}/welcome")

end