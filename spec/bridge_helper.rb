require 'rest-client'
require 'require_all'
require 'base64'
require 'json'
require 'json-schema'
require 'securerandom'
require_all File.dirname(__FILE__) + '/../lib/api/bridge'

RSpec.configure do |config|
  config.formatter = :documentation

  config.before(:all) do
    @authorisation = "Basic #{Base64.strict_encode64(ENV['bridge_username']+':'+ENV['bridge_password'])}"
  end

  config.before(:each) do
    @t1 = Time.now
  end

  config.after(:each) do
    puts 'Test time: ' + (Time.now - @t1).to_s
  end

  def assert_code_and_body(response, status_code)
    fail('Failed with ' + response.code.to_s) if response.code != status_code
  end

end
