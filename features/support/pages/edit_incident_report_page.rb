require_relative '../modules/create_content_type_items'

class EditIncidentReportPage
  include PageObject
  include CreateContentTypeItems
  extend UrlFactory

  page_url(incidentreporteditpage)

end
