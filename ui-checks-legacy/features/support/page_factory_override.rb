require 'page-object/page_factory'

module PageFactoryOverride
  extend PageObject::PageFactory

  def visit_and_benchmark(page_class, params={:using_params => {}}, &block)
    visit(page_class, params, &block)

    if ENV['browser'] != 'phantom'
      load_secs = @browser.performance.summary[:response_time]/1000
      puts "Page load time: #{load_secs} seconds."
    end
  end

  def switch_user user
    if @browser
      @browser.cookies.delete 'jive.security.context'
      @browser.cookies.add 'jive.security.context', $browsers[user].split('jive.security.context=')[1]
    else
      $authorisation = $browsers[user]
    end
  end
end
