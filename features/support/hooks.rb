require 'watir-webdriver'
require 'syntax'

$browsers = {}
$users = {}

driver = nil
using_ui = false
config = TestConfig.get_config_set

['participant A','participant B','admin'].each do |user|
  case user
    when 'participant A'
      @username = config[:user_1_name]
      @password = config[:user_1_password]
      $browsers[user] = Login.do_login(@username,@password)
      $user1_id = Login.get_user_id($browsers[user]).to_s
      $custom_space_id = Places.get_space_id(ENV['custom_space'],$browsers[user]).to_s
      $private_group_id = Places.get_group_id(ENV['private_group'],'private-group',$browsers[user]).to_s
    when 'participant B'
      @username = config[:user_2_name]
      @password = config[:user_2_password]
      $browsers[user] = Login.do_login(@username,@password)
      $user2_id = Login.get_user_id($browsers[user]).to_s
      $custom_space_id = Places.get_space_id(ENV['custom_space'],$browsers[user]).to_s
      $private_group_id = Places.get_group_id(ENV['private_group'],'private-group',$browsers[user]).to_s
      $secret_group_id = Places.get_group_id(ENV['secret_group'],'secret-group',$browsers[user]).to_s
    when 'admin'
      @username = config[:admin_name]
      @password = config[:admin_password]
      $browsers[user] = Login.do_login(@username,@password)
      $admin_id = Login.get_user_id($browsers[user]).to_s
      $custom_space_id = Places.get_space_id(ENV['custom_space'],$browsers[user]).to_s
      $private_group_id = Places.get_group_id(ENV['private_group'],'private-group',$browsers[user]).to_s
      $secret_group_id = Places.get_group_id(ENV['secret_group'],'secret-group',$browsers[user]).to_s
    else
      fail 'Supplied user not recognised.'
  end

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
