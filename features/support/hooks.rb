require 'watir-webdriver'
require 'syntax'

driver = BrowserFactory.create

Before do
  @browser = driver
end

After do |scenario|
  if scenario.failed?
    embed_screenshot(scenario.title)
  end

  @browser.cookies.clear
  visit(LoginPage)
end

at_exit do
  driver.close
end

private

def embed_screenshot(scenarioTitle)
  directory_name = "./reporting/screenshots"
  Dir.mkdir(directory_name) unless File.exists?(directory_name)

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
