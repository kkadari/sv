require 'open-uri'

class BlogPostPdfPage
  include PageObject
  
  page_url(/#{FigNewton.base_url}\/people\S+.pdf/)
  
  def pdf_includes(text)
    url = @browser.url
    puts "PDF URL (input): #{url}"
    
    begin
      reader = PDF::Reader.new(open(url))
      reader.pages.each do |page|
        @found = page.text.include? text
      end
    rescue PDF::Reader::MalformedPDFError
      puts "Malformed PDF error. Exiting."
      exit
    end
    fail "#{text} not found in PDF" unless @found
  end
end