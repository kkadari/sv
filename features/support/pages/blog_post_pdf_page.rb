require 'open-uri'

class BlogPostPdfPage
  include PageObject
  extend UrlFactory
  
  page_url(blogpostpdfpage)
  
  def pdf_includes(text)
    url = @browser.url
    puts "PDF URL (input): #{url}"
    
    begin
      reader = PDF::Reader.new(open(url))
      reader.pages.each do |page|
        @found = page.text.include? text
      end
    rescue PDF::Reader::MalformedPDFError
      puts 'Malformed PDF error. Exiting.'
      exit
    end
    raise "#{text} not found in PDF" unless @found
  end
end