require 'watir-webdriver'
require 'syntax'

Before do
  case ENV['browser']
    when 'firefox'
      # On ABC-108, bypass proxy with following script:
      # /etc/profile.d/proxy.sh
      # export http_proxy="http://proxy.com:8000"
      # export no_proxy="127.0.0.1, localhost"
      profile = Selenium::WebDriver::Firefox::Profile.new
      # profile['browser.helperApps.neverAsk.saveToDisk'] = "text/csv,application/pdf"
      @browser = Watir::Browser.new :firefox #, :profile => profile
      # ABC-108 profile config additions:
      # profile.proxy = Selenium::WebDriver::Proxy.new :http => false, :ssl => false
      # profile['proxy.no_proxies_for']='localhost, 127.0.0.1'
      @browser.window.resize_to(1440, 900)
    when 'chrome'
      @browser = Watir::Browser.new :chrome
    else # Not specified? Use Firefox.
      profile = Selenium::WebDriver::Firefox::Profile.new
      # profile['browser.helperApps.neverAsk.saveToDisk'] = "text/csv,application/pdf"
      @browser = Watir::Browser.new :firefox #, :profile => profile
      @browser.window.resize_to(1440, 900)
  end
end

After do |scenario|
  if scenario.failed?
    embed_screenshot(scenario.title)
  end
  @browser.close
end

private

def embed_screenshot(scenarioTitle)
  scenarioTitle = scenarioTitle.tr(' ', '_')
  @browser.driver.save_screenshot("./reporting/screenshots/#{scenarioTitle}_screenshot.png")
  # Workaround for bug whereby an attempt is made to open
  # the image file (from the wrong working DIR)
  # https://github.com/cucumber/cucumber/blob/v1.3.16/lib/cucumber/formatter/gherkin_formatter_adapter.rb#L86
  # Open fails and emits an error
  # The workaround is to  create two images, one to satisfy the erroneous open and one
  # to embed in the HTML
  @browser.driver.save_screenshot("./screenshots/#{scenarioTitle}_screenshot.png")

  # HTML report is served from ./reporting so this will read ./reporting/screenshots from the HTML
  # but when this embed is called the file open command will read from ./screenshots
  embed("screenshots/#{scenarioTitle}_screenshot.png", "image/png")
end
