module PdfExport
  include PageObject
  
  def export_to_pdf
    @browser.link(:text => /View as PDF/).when_present.click
  end
end