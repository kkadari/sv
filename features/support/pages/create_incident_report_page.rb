require_relative '../modules/create_content_type_items'

class CreateIncidentReportPage
  include PageObject
  include DataMagic
  include CreateContentTypeItems
  extend UrlFactory

  page_url(incidentreportpage)

end
