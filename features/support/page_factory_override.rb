require 'page-object/page_factory'

module PageFactoryOverride
  extend PageObject::PageFactory

  def visit_and_benchmark(page_class, params={:using_params => {}}, &block)
    visit(page_class, params, &block)
    load_secs = @browser.performance.summary[:response_time]/1000
    puts "Page load time: #{load_secs} seconds."
  end
end