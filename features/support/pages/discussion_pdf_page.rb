class DiscussionPdfPage
  include PageObject
  
  page_url(/#{FigNewton.base_url}\/thread\S\d+.pdf/)
  
  def pdf_includes(text)
    fail "#{text} not found in PDF" unless @browser.html.include? text
  end
end