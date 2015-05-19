class ActivityPage
  include PageObject
  extend UrlFactory

  page_url(activitypage)
  divs(:incident_report,:class => 'j-act-entry')
end
