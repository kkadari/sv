require_relative './shared/shared_create_content_items'

class EditIncidentReportPage
  include PageObject
  include SharedCreateContentItems
  extend UrlFactory

  page_url(incidentreporteditpage)

end
