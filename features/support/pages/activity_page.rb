require_relative '../modules/nav_ribbon'

class ActivityPage
  include PageObject
  include NavRibbon
  extend UrlFactory

  page_url(activitypage)
  divs(:incident_report,:class => 'j-act-entry')

end
