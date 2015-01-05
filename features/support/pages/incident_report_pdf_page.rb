class IncidentReportPdfPage
  include PageObject
  
  page_url(/#{FigNewton.base_url}\/incidentreports\S\d+.pdf/)
  
  def pdf_includes(text)
    fail "#{text} not found in PDF" unless @browser.html.include? text
  end
end