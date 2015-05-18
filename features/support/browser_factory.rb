module BrowserFactory

  def self.create
    Watir.default_timeout = 15

    case ENV['browser']
      when 'firefox'
        # On ABC-108, bypass proxy with following script:
        # /etc/profile.d/proxy.sh
        # export http_proxy="http://proxy.com:8000"
        # export no_proxy="127.0.0.1, localhost"
        profile = Selenium::WebDriver::Firefox::Profile.new
        profile['browser.helperApps.neverAsk.saveToDisk'] = "text/csv,application/pdf"
        driver = Watir::Browser.new :firefox, :profile => profile
        # ABC-108 profile config additions:
        # profile.proxy = Selenium::WebDriver::Proxy.new :http => false, :ssl => false
        # profile['proxy.no_proxies_for']='localhost, 127.0.0.1'
      when 'chrome'
        driver = Watir::Browser.new :chrome
      when 'phantom'
        driver = Watir::Browser.new :remote, url: 'http://localhost:8001'
      else # Not specified? Use Firefox.
        puts 'ENV[\'Browser\'] wasn\'t set.  Reverting to Firefox.'
        profile = Selenium::WebDriver::Firefox::Profile.new
        profile['browser.helperApps.neverAsk.saveToDisk'] = "text/csv,application/pdf"
        driver = Watir::Browser.new :firefox, :profile => profile
    end

    driver.window.resize_to(1440, 900)
    return driver
  end

end