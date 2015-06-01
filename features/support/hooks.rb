require 'watir-webdriver'
require 'syntax'

$browsers = {}

@test_config_set = TestConfig.get_config_set(ENV['TEST_ENV_NUMBER'])

['participant A','participant B','admin'].each do |user|
  $browsers[user] = BrowserFactory.create

  case user
    when 'participant A'
      @username = @test_config_set[:user_1_name]
      @password = @test_config_set[:user_1_password]
    when 'participant B'
      @username = @test_config_set[:user_2_name]
      @password = @test_config_set[:user_2_password]
    when 'admin'
      @username = @test_config_set[:admin_name]
      @password = @test_config_set[:admin_password]

    else
      fail 'Supplied user not recognised.'
  end

  @browser = $browsers[user]

  login_page = LoginPage.new(@browser)
  @browser.goto('http://dev188.sure.vine/')
  login_page.username = @username
  login_page.password = @password
  login_page.submit
end

After do |scenario|
  if scenario.failed?
    embed_screenshot(scenario.title)
  end
end

at_exit do
  $browsers['participant A'].close
  $browsers['participant B'].close
  $browsers['admin'].close
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
