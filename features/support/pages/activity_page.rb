require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class ActivityPage
  include PageObject
  include NavRibbon
  include UserModal
  extend UrlFactory

  page_url(activitypage)
  divs(:incident_report,:class => 'j-act-entry')

end
