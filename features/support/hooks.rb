require 'watir-webdriver'
require 'syntax'

$browsers = {}

driver = nil
using_ui = false
config = TestConfig.get_config_set

['participant A','participant B','admin'].each do |user|
  case user
    when 'participant A'
      @username = config[:user_1_name]
      @password = config[:user_1_password]
    when 'participant B'
      @username = config[:user_2_name]
      @password = config[:user_2_password]
    when 'admin'
      @username = config[:admin_name]
      @password = config[:admin_password]

    else
      fail 'Supplied user not recognised.'
  end

  $browsers[user] = Login.do_login(@username,@password)
end

Before('@sit, @ui') do
  using_ui = true
  @test_config_set = config

  driver = BrowserFactory.create
  @browser = driver
  @browser.goto(ENV['base_url'] + '/welcome')
end

Before('~@sit, ~@ui') do
  @test_config_set = config
end

After('@sit, @ui') do |scenario|
  if scenario.failed?
    embed_screenshot(scenario.name)
  end
end

at_exit do
  driver.close if using_ui
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
  # The workaround is to create two images, one to satisfy the erroneous open and one
  # to embed in the HTML
  @browser.driver.save_screenshot("./screenshots/#{scenario_title}_screenshot.png")

  # HTML report is served from ./reporting so this will read ./reporting/screenshots from the HTML
  # but when this embed is called the file open command will read from ./screenshots
  embed("screenshots/#{scenario_title}_screenshot.png", "image/png")
end
