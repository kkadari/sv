require_relative './shared/shared_create_content_items'

class CreateIncidentReportPage
  include PageObject
  include SharedCreateContentItems
  extend UrlFactory

  page_url(incidentreportpage)

end