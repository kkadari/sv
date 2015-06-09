require 'rest-client'
require 'require_all'
require 'base64'
require 'faker'
require_all File.dirname(__FILE__) + '/../lib/content_payloads/'

RSpec.configure do |config|
  config.before(:all) do
    payload = 'username=' + CGI.escape(ENV['username']) + '&password=' + CGI.escape(ENV['password'])

    RestClient.post('http://dev188.sure.vine/cs_login',payload){ |response|
      @authorisation = response.headers[:set_cookie]
    }
  end

  config.before(:each) do
    @t1 = Time.now
  end

  config.after(:each) do
    puts 'Test time: ' + (Time.now - @t1).to_s
  end
end