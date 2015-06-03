module BrowserFactory

  def self.create
    Watir.default_timeout = 10

    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 180 # seconds – default is 60

    case ENV['browser']
      when 'firefox'
        # tmp_folder = File.dirname(__FILE__) + '/../../reporting/tmp'
        # FileUtils.rm_rf(tmp_folder) if File.exists?(tmp_folder)
        # Dir.mkdir(tmp_folder) unless File.exists?(tmp_folder)
        #
        # firebug_path = File.dirname(__FILE__) + '/../../bin/firebug-2.0.9-fx.xpi'
        # net_export_path = File.dirname(__FILE__) + '/../../bin/netExport-0.9b7.xpi'
        #
        profile = Selenium::WebDriver::Firefox::Profile.new
        # profile.add_extension(firebug_path)
        # profile.add_extension(net_export_path)
        #
        # profile['extensions.firebug.allPagesActivation']  = 'on'
        # profile['extensions.firebug.currentVersion'] = '2.0.9'
        # profile['extensions.firebug.DBG_NETEXPORT'] = false
        # profile['extensions.firebug.onByDefault'] = true
        # profile['extensions.firebug.defaultPanelName'] = 'net'
        # profile['extensions.firebug.net.enableSites'] = true
        # profile['extensions.firebug.net.defaultPersist'] = true
        # profile['extensions.firebug.netexport.alwaysEnableAutoExport'] = true
        # profile['extensions.firebug.netexport.autoExportToFile'] = true
        # profile['extensions.firebug.netexport.autoExportToServer'] = false
        # profile['extensions.firebug.netexport.defaultLogDir'] = File.dirname(__FILE__) + '/../../reporting/tmp'
        # profile['extensions.firebug.netexport.showPreview'] = true
        # profile['extensions.firebug.netexport.sendToConfirmation'] = false
        # profile['extensions.firebug.netexport.Automation'] = true
        profile['browser.helperApps.neverAsk.saveToDisk'] = 'text/csv,application/pdf'
        driver = Watir::Browser.new :firefox, :profile => profile, :http_client => client

        # ABC-108 profile config additions:
        # profile.proxy = Selenium::WebDriver::Proxy.new :http => false, :ssl => false
        # profile['proxy.no_proxies_for']='localhost, 127.0.0.1'
      when 'chrome'
        driver = Watir::Browser.new :chrome, :http_client => client
      when 'phantom'
        driver = Watir::Browser.new :remote, url: 'http://localhost:8001', :http_client => client
      else # Not specified? Use Firefox.
        puts 'ENV[\'Browser\'] wasn\'t set.  Reverting to Firefox.'
        profile = Selenium::WebDriver::Firefox::Profile.new
        profile['browser.helperApps.neverAsk.saveToDisk'] = 'text/csv,application/pdf'
        driver = Watir::Browser.new :firefox, :profile => profile, :http_client => client
    end

    driver.window.resize_to(1440, 900)
    return driver
  end

end