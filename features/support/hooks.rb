require 'watir-webdriver'
require 'syntax'

$browsers = {}

driver = BrowserFactory.create
config = TestConfig.get_config_set(ENV['TEST_ENV_NUMBER'])

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

Before do
  @browser = driver
  @test_config_set = config

  @browser.goto(ENV['base_url'] + '/welcome')
end

AfterStep do
  if ENV['browser'] != 'phantom'
    load_secs = @browser.performance.summary[:response_time]/1000
    puts "Step benchmark: #{load_secs} seconds."
  end
end

After do |scenario|
  if scenario.failed?
    embed_screenshot(scenario.title)
  end
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
