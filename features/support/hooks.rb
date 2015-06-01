require 'watir-webdriver'
require 'syntax'

driver = BrowserFactory.create

Before do
  @browser = driver
  @test_config_set = TestConfig.get_config_set(ENV['TEST_ENV_NUMBER'])
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

def embed_screenshot(scenario_title)
  directory_name = './reporting/screenshots'
  Dir.mkdir(directory_name) unless File.exists?(directory_name)

  scenario_title = scenario_title.tr(' ', '_')
  @browser.driver.save_screenshot("./reporting/screenshots/#{scenario_title}_screenshot.png")
  # Workaround for bug whereby an attempt is made to open
  # the image file (from the wrong working DIR)
  # https://github.com/cucumber/cucumber/blob/v1.3.16/lib/cucumber/formatter/gherkin_formatter_adapter.rb#L86
  # Open fails and emits an error
  # The workaround is to  create two images, one to satisfy the erroneous open and one
  # to embed in the HTML
  @browser.driver.save_screenshot("./screenshots/#{scenario_title}_screenshot.png")

  # HTML report is served from ./reporting so this will read ./reporting/screenshots from the HTML
  # but when this embed is called the file open command will read from ./screenshots
  embed("screenshots/#{scenario_title}_screenshot.png", "image/png")
end
