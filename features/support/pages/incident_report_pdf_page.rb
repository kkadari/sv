class IncidentReportPdfPage
  include PageObject
  extend UrlFactory
  
  page_url(incidentreportpdfpage)
  
  def pdf_includes(text)
    fail "#{text} not found in PDF" unless @browser.html.include? text
  end
end